//
//  OceanTheme.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 21/10/26.
//

import SwiftUI

/// The user's preferred look: follow the system, or force sunlight (light) / moonlight (dark).
enum AppAppearance: String, CaseIterable, Identifiable {
    case system = "System"
    case sunlight = "Sunlight"
    case moonlight = "Moonlight"

    var id: Self { self }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .sunlight:
            return .light
        case .moonlight:
            return .dark
        }
    }

    var systemImage: String {
        switch self {
        case .system:
            return "circle.lefthalf.filled"
        case .sunlight:
            return "sun.max.fill"
        case .moonlight:
            return "moon.stars.fill"
        }
    }
}

/// Ocean palette: light blues for waves under sunlight, deep blues for waves under moonlight.
enum OceanTheme {
    static func skyColors(for scheme: ColorScheme) -> [Color] {
        scheme == .dark
            ? [Color(hex: 0x050D24), Color(hex: 0x0B1F4A), Color(hex: 0x123468)]
            : [Color(hex: 0xE6F7FF), Color(hex: 0xBDE8FB), Color(hex: 0x8ED4F5)]
    }

    static func waveColors(for scheme: ColorScheme) -> [Color] {
        scheme == .dark
            ? [Color(hex: 0x1D4F91), Color(hex: 0x163E78), Color(hex: 0x0D2A57)]
            : [Color(hex: 0x7CCCF2), Color(hex: 0x45AEE6), Color(hex: 0x1E8AD0)]
    }

    static func glowColor(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0xDCE8FF) : Color(hex: 0xFFE7A3)
    }

    static func accent(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(hex: 0x5FA8FF) : Color(hex: 0x1E8AD0)
    }
}

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

/// Full-bleed animated background: a sky gradient, the sun or moon, and three layers of rolling waves.
struct OceanBackground: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Turn off in secondary columns so a split layout shows a single sun or moon.
    var showsCelestialBody = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: OceanTheme.skyColors(for: colorScheme),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Stays inside the safe area so it never sits under the camera or a corner.
            if showsCelestialBody {
                celestialBody
            }

            TimelineView(.animation(paused: reduceMotion)) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate
                Canvas { context, size in
                    drawWaves(in: &context, size: size, time: time)
                }
            }
            .ignoresSafeArea()
        }
        .accessibilityHidden(true)
    }

    /// The sun during sunlight, the moon during moonlight, glowing in the top trailing corner.
    private var celestialBody: some View {
        let glow = OceanTheme.glowColor(for: colorScheme)
        return Circle()
            .fill(glow)
            .frame(width: 70, height: 70)
            .shadow(color: glow.opacity(0.8), radius: 40)
            .overlay {
                if colorScheme == .dark {
                    // Offset circle in the sky color carves out a crescent moon.
                    Circle()
                        .fill(OceanTheme.skyColors(for: colorScheme)[0])
                        .frame(width: 58, height: 58)
                        .offset(x: 16, y: -10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.top, 16)
            .padding(.trailing, 32)
    }

    /// Draws stacked sine waves along the bottom of the canvas, each drifting at its own speed.
    private func drawWaves(in context: inout GraphicsContext, size: CGSize, time: TimeInterval) {
        let colors = OceanTheme.waveColors(for: colorScheme)

        for (index, color) in colors.enumerated() {
            let layer = Double(index)
            let baseline = size.height * (0.74 + 0.07 * layer)
            let amplitude = 10.0 + 4.0 * layer
            let wavelength = 240.0 - 40.0 * layer
            let phase = time * (0.6 + 0.25 * layer) + layer * 1.3

            var path = Path()
            path.move(to: CGPoint(x: 0, y: size.height))
            for x in stride(from: 0.0, through: size.width, by: 4) {
                let y = baseline + sin(x / wavelength * 2 * .pi + phase) * amplitude
                path.addLine(to: CGPoint(x: x, y: y))
            }
            path.addLine(to: CGPoint(x: size.width, y: size.height))
            path.closeSubpath()

            context.fill(path, with: .color(color.opacity(0.75 + 0.08 * layer)))
        }
    }
}

#Preview("Sunlight") {
    OceanBackground()
        .preferredColorScheme(.light)
}

#Preview("Moonlight") {
    OceanBackground()
        .preferredColorScheme(.dark)
}

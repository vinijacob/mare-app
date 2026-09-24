//
//  MoodEnum.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//
import SwiftUI
import Foundation

enum MoodEnum: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        self
    }

    // MARK: - Amor e alegria
    case inLove = "In Love"
    case happy = "Happy"
    case golden = "Golden"
    case joyful = "Joyful"
    case crazy = "Crazy"

    // MARK: - Calma
    case saint = "Saint"
    case peaceful = "Peaceful"

    // MARK: - Nostalgia
    case nostalgic = "Nostalgic"
    case melancholic = "Melancholic"

    // MARK: - Tristeza
    case sad = "Sad"
    case lonely = "Lonely"
    case anxious = "Anxious"

    // MARK: - Cansaço e mal-estar
    case exhausted = "Exhausted"
    case sleepy = "Sleepy"
    case sick = "Sick"
    case melting = "Melting"
    case likeShit = "Like Shit"

    // MARK: - Irritação
    case grumpy = "Grumpy"
    case furious = "Furious"

    var emoji: String {
        switch self {
        case .inLove:
            return "😍"
        case .happy:
            return "😊"
        case .golden:
            return "🤩"
        case .joyful:
            return "🥳"
        case .crazy:
            return "😛"
        case .saint:
            return "😇"
        case .peaceful:
            return "😌"
        case .nostalgic:
            return "🥹"
        case .melancholic:
            return "🌧️"
        case .sad:
            return "😞"
        case .lonely:
            return "🫥"
        case .anxious:
            return "😰"
        case .exhausted:
            return "🫩"
        case .sleepy:
            return "😴"
        case .sick:
            return "🤒"
        case .melting:
            return "🫠"
        case .likeShit:
            return "💩"
        case .grumpy:
            return "😠"
        case .furious:
            return "😤"
        }
    }

    var color: Color {
        switch self {
        case .inLove, .happy, .golden, .joyful, .crazy:
            return .yellow
        case .saint, .peaceful:
            return .green
        case .nostalgic, .melancholic:
            return .purple
        case .sad, .lonely, .anxious:
            return .blue
        case .exhausted, .sleepy, .sick, .melting, .likeShit:
            return .orange
        case .grumpy, .furious:
            return .red
        }
    }

    var commentPlaceholder: String {
        switch self {
        case .inLove:
            return "Feeling in love..."
        case .happy:
            return "Feeling happy..."
        case .golden:
            return "Feeling like Golden..."
        case .joyful:
            return "Feeling joyful..."
        case .crazy:
            return "Feeling a little crazy..."
        case .saint:
            return "Feeling like a saint..."
        case .peaceful:
            return "Feeling peaceful..."
        case .nostalgic:
            return "Feeling nostalgic..."
        case .melancholic:
            return "Feeling melancholic..."
        case .sad:
            return "Feeling sad..."
        case .lonely:
            return "Feeling lonely..."
        case .anxious:
            return "Feeling anxious..."
        case .exhausted:
            return "Feeling exhausted..."
        case .sleepy:
            return "Feeling sleepy..."
        case .sick:
            return "Feeling sick..."
        case .melting:
            return "Feeling like I'm melting..."
        case .likeShit:
            return "Feeling like shit..."
        case .grumpy:
            return "Feeling grumpy..."
        case .furious:
            return "Feeling furious..."
        }
    }
}

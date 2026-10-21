//
//  ProfileView.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 21/10/26.
//

import SwiftData
import SwiftUI

struct ProfileView: View {
    @AppStorage(UserProfile.usernameKey) private var username: String = ""
    @AppStorage(UserProfile.emailKey) private var email: String = ""
    @AppStorage(UserProfile.birthdayKey) private var birthdayInterval: Double = 0
    @AppStorage(UserProfile.appearanceKey) private var appearance: AppAppearance = .system

    @Query private var userLogs: [Mood]

    private var birthday: Date? {
        UserProfile.birthday(from: birthdayInterval)
    }

    private var birthdayBinding: Binding<Date> {
        Binding {
            birthday ?? .now
        } set: { newValue in
            birthdayInterval = newValue.timeIntervalSince1970
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                header

                Section("About You") {
                    LabeledContent {
                        TextField("Your name", text: $username)
                            .textContentType(.username)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Label("Username", systemImage: "person.fill")
                    }

                    LabeledContent {
                        TextField("you@example.com", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Label("Email", systemImage: "envelope.fill")
                    }

                    if !email.isEmpty && !UserProfile.isValidEmail(email) {
                        Label("That email doesn't look quite right.", systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(.orange)
                    }

                    if birthday != nil {
                        DatePicker(
                            selection: birthdayBinding,
                            in: ...Date.now,
                            displayedComponents: .date
                        ) {
                            Label("Birthday", systemImage: "gift.fill")
                        }
                    } else {
                        Button {
                            birthdayInterval = Date.now.timeIntervalSince1970
                        } label: {
                            Label("Add Birthday", systemImage: "gift")
                        }
                    }
                }

                if let birthday {
                    Section("Birthday") {
                        LabeledContent("Age", value: "\(UserProfile.age(from: birthday))")
                        let days = UserProfile.daysUntilNextBirthday(birthday)
                        LabeledContent("Next birthday", value: days == 0 ? "Today! 🎉" : "in \(days) days")
                        Button("Remove Birthday", role: .destructive) {
                            birthdayInterval = 0
                        }
                    }
                }

                Section("Your Tides") {
                    LabeledContent {
                        Text("\(userLogs.count)")
                    } label: {
                        Label("Entries", systemImage: "water.waves")
                    }
                    LabeledContent {
                        Text("\(userLogs.currentStreak()) days")
                    } label: {
                        Label("Current streak", systemImage: "flame.fill")
                    }
                    if let favorite = userLogs.favoriteMood {
                        LabeledContent {
                            Text("\(favorite.emoji) \(favorite.rawValue)")
                        } label: {
                            Label("Most felt", systemImage: "heart.fill")
                        }
                    }
                }

                Section {
                    Picker("Theme", selection: $appearance) {
                        ForEach(AppAppearance.allCases) { option in
                            Label(option.rawValue, systemImage: option.systemImage)
                                .tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Sunlight paints the waves light blue; moonlight turns them deep blue.")
                }
            }
            .scrollContentBackground(.hidden)
            .background { OceanBackground() }
            .navigationTitle("Profile")
        }
    }

    private var header: some View {
        Section {
            HStack(spacing: 16) {
                Text(initials)
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(.tint, in: .circle)

                VStack(alignment: .leading, spacing: 4) {
                    Text(username.isEmpty ? "Sailor" : username)
                        .font(.title2.bold())
                    if UserProfile.isBirthdayToday(birthday) {
                        Text("Happy birthday! 🎂")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else if !email.isEmpty {
                        Text(email)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .accessibilityElement(children: .combine)
        }
    }

    private var initials: String {
        let letters = username
            .split(separator: " ")
            .prefix(2)
            .compactMap(\.first)
        return letters.isEmpty ? "🌊" : String(letters).uppercased()
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: Mood.self, inMemory: true)
}

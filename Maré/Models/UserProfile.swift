//
//  UserProfile.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 21/10/26.
//

import Foundation

/// `@AppStorage` keys and helpers for the user's profile.
/// The birthday is stored as a time interval since 1970; `0` means "not set".
enum UserProfile {
    static let usernameKey = "profile.username"
    static let emailKey = "profile.email"
    static let birthdayKey = "profile.birthday"
    static let appearanceKey = "profile.appearance"

    static func isValidEmail(_ email: String) -> Bool {
        email.wholeMatch(of: /[^@\s]+@[^@\s]+\.[^@\s]+/) != nil
    }

    static func birthday(from interval: Double) -> Date? {
        interval == 0 ? nil : Date(timeIntervalSince1970: interval)
    }

    static func isBirthdayToday(_ birthday: Date?, calendar: Calendar = .current) -> Bool {
        guard let birthday else { return false }
        let birth = calendar.dateComponents([.month, .day], from: birthday)
        let today = calendar.dateComponents([.month, .day], from: .now)
        return birth.month == today.month && birth.day == today.day
    }

    static func age(from birthday: Date, calendar: Calendar = .current) -> Int {
        calendar.dateComponents([.year], from: birthday, to: .now).year ?? 0
    }

    /// Days until the next birthday; `0` means today.
    static func daysUntilNextBirthday(_ birthday: Date, calendar: Calendar = .current) -> Int {
        let components = calendar.dateComponents([.month, .day], from: birthday)
        let today = calendar.startOfDay(for: .now)
        guard let next = calendar.nextDate(
            after: today.addingTimeInterval(-1),
            matching: components,
            matchingPolicy: .nextTimePreservingSmallerComponents
        ) else { return 0 }
        return calendar.dateComponents([.day], from: today, to: next).day ?? 0
    }

    /// A greeting that follows the sun: morning, afternoon, evening or night.
    static func greeting(for date: Date = .now, calendar: Calendar = .current) -> String {
        switch calendar.component(.hour, from: date) {
        case 5..<12:
            return "Good morning"
        case 12..<18:
            return "Good afternoon"
        case 18..<22:
            return "Good evening"
        default:
            return "Good night"
        }
    }
}

extension Array where Element == Mood {
    /// Consecutive days with at least one entry, counting back from today (or yesterday if today has none yet).
    func currentStreak(calendar: Calendar = .current) -> Int {
        let loggedDays = Set(map { calendar.startOfDay(for: $0.date) })
        var day = calendar.startOfDay(for: .now)
        if !loggedDays.contains(day) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: day) else { return 0 }
            day = yesterday
        }

        var streak = 0
        while loggedDays.contains(day) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }
        return streak
    }

    /// The mood logged most often, if any.
    var favoriteMood: MoodEnum? {
        let counts = Dictionary(grouping: self, by: \.currentMood).mapValues(\.count)
        return counts.max { $0.value < $1.value }?.key
    }
}

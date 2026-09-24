//
//  MoodEnum.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//
import Foundation

enum MoodEnum: String, CaseIterable, Codable, Identifiable {
    var id: Self {
        self
    }

    case grumpy = "Grumpy"
    case happy = "Happy"
    case sad = "Sad"
    case nostalgic = "Nostalgic"
    case inLove = "In Love"
    case exhausted = "Exhausted"
    case sleepy = "Sleepy"
    case sick = "Sick"
    case crazy = "Crazy"
    case furious = "Furious"
    case melting = "Melting"
    case likeShit = "Like Shit"
    case saint = "Saint"
    case golden = "Golden"

    var emoji: String {
        switch self {
        case .grumpy:
            return "😠"
        case .happy:
            return "😊"
        case .sad:
            return "😞"
        case .nostalgic:
            return "🥹"
        case .inLove:
            return "😍"
        case .exhausted:
            return "🫩"
        case .sleepy:
            return "😴"
        case .sick:
            return "🤒"
        case .crazy:
            return "😛"
        case .furious:
            return "😤"
        case .melting:
            return "🫠"
        case .likeShit:
            return "💩"
        case .saint:
            return "😇"
        case .golden:
            return "🤩"
        }
    }

    var commentPlaceholder: String {
        switch self {
        case .grumpy:
            return "Feeling grumpy..."
        case .happy:
            return "Feeling happy..."
        case .sad:
            return "Feeling sad..."
        case .nostalgic:
            return "Feeling nostalgic..."
        case .inLove:
            return "Feeling in love..."
        case .exhausted:
            return "Feeling exhausted..."
        case .sleepy:
            return "Feeling sleepy..."
        case .sick:
            return "Feeling sick..."
        case .crazy:
            return "Feeling a little crazy..."
        case .furious:
            return "Feeling furious..."
        case .melting:
            return "Feeling like I'm melting..."
        case .likeShit:
            return "Feeling like shit..."
        case .saint:
            return "Feeling like a saint..."
        case .golden:
            return "Feeling like Golden..."
        }
    }
}

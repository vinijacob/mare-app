//
//  MoodEnum.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import Foundation

enum MoodEnum: String, CaseIterable, Codable, Identifiable {
    var id: Self {self}
    
    case grumpy = "Grumpy 😠"
    case happy = "Happy 😊"
    case sad = "Sad 😞"
    case nostalgic = "Nostalgic 🥹"
    case inLove = "In Love 😍"
    case exhausted = "Exhausted 🫩"
    case sleepy = "Sleepy 😴"
    case sick = "Sick 🤒"
    case crazy = "Crazy 😛"
    case furious = "Furious 😤"
    case melting = "Melting 🫠"
    case likeShit = "Like Shit 💩"
    case saint = "Saint 😇"
}

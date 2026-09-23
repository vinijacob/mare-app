//
//  MoodEnum.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import Foundation

enum Mood: String, CaseIterable, Codable {
    case grumpy = "Grumpy"
    case happy = "Happy"
    case sad = "Sad"
    case nostalgic = "Nostalgic"
    case bucolic = "Bucolic"
}

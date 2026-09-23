//
//  MoodRegister.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 23/09/26.
//

import Foundation
import SwiftData

@Model
class MoodRegister {
    @Attribute(.unique) var id: UUID
    var currentMood: Mood
    var comment: String
    var tags: [String]
    var date: Date
    
    init(id: UUID = UUID(), currentMood: Mood, comment: String = "", tags: [String] = [], date: Date = .now) {
        self.id = id
        self.currentMood = currentMood
        self.comment = comment
        self.tags = tags
        self.date = date
    }
}

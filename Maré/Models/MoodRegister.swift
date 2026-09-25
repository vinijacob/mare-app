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
    var currentMood: MoodEnum
    var comment: String
    var date: Date
    
    init(id: UUID = UUID(), currentMood: MoodEnum, comment: String = "", date: Date = .now) {
        self.id = id
        self.currentMood = currentMood
        self.comment = comment
        self.date = date
    }
}

extension MoodRegister {
    var displayComment: String {
        comment.isEmpty ? "No Comment." : comment
    }
}

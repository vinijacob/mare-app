//
//  sourcecode.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 24/09/26.
//

import SwiftData
import SwiftUI

struct UserLogsView: View {
    @Query private var userLogs: [MoodRegister]

    var body: some View {
        VStack {
            Text("User Logs")
                .font(.largeTitle.bold())

            // split via dates
            List {
                ForEach(userLogs) { userLog in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(userLog.currentMood.emoji) — \(userLog.currentMood.rawValue)")
                                .bold()
                            HStack {
                                Text(userLog.displayComment)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(userLog.date.formatted(.dateTime.day().month(.twoDigits).year().hour().minute()))
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserLogsView()
        .modelContainer(for: MoodRegister.self, inMemory: true)
}

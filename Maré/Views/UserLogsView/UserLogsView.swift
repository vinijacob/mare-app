//
//  sourcecode.swift
//  Maré
//
//  Created by Vinicius Ramos Jacob on 24/09/26.
//

import SwiftData
import SwiftUI

struct UserLogsView: View {
    @Query(sort: \Mood.date) private var userLogs: [Mood]
    @Environment(\.modelContext) private var context

    @State private var newLog: Mood?

    var body: some View {
        NavigationSplitView {
            Group {
                if !userLogs.isEmpty {
                    List {
                        ForEach(userLogs) { userLog in
                            NavigationLink {
                                UserLogsDetail(userLog: userLog)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(userLog.currentMood.emoji) — \(userLog.currentMood.rawValue)")
                                        .font(.headline)

                                    HStack {
                                        Text(userLog.displayComment)
                                            .lineLimit(1)

                                        Spacer()

                                        Text(userLog.date.formatted(.dateTime.day().month(.abbreviated)))
                                    }
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteLog(indexes:))
                    }
                } else {
                    ContentUnavailableView(
                        "No logs",
                        systemImage: "waveform.path.ecg"
                    )
                }
            }
            .navigationTitle("User Logs")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select a log")
        }
    }

    private func deleteLog(indexes: IndexSet) {
        for index in indexes {
            context.delete(userLogs[index])
        }
    }
}

#Preview {
    UserLogsView()
        .modelContainer(for: Mood.self, inMemory: true)
}

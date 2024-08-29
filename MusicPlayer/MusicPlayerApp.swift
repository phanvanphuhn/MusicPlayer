//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Phan Van Phu on 29/08/2024.
//

import SwiftUI

@main
struct MusicPlayerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  SpaceWarApp.swift
//  SpaceWar
//
//  Created by 陳加升 on 2025/12/5.
//

import SwiftUI

@main
struct SpaceWarApp: App {

    @State private var gameState = GameState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameState)
        }

        ImmersiveSpace(id: "GameSpace") {
            ImmersiveView()
                .environment(gameState)
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}

//
//  PauseMenu.swift
//  SpaceWar
//
//  暫停選單
//

import SwiftUI

struct PauseMenu: View {

    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack(spacing: 20) {
            Text("Paused")
                .font(.largeTitle)
                .bold()

            Button("Resume") {
                gameState.resumeGame()
            }
            .buttonStyle(.bordered)

            Button("Restart") {
                gameState.startGame()
            }
            .buttonStyle(.bordered)

            Button("Quit to Menu") {
                gameState.reset()
            }
            .buttonStyle(.bordered)
        }
        .padding(40)
        .background(.regularMaterial)
        .cornerRadius(20)
    }
}

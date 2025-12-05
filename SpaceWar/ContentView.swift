//
//  ContentView.swift
//  SpaceWar
//
//  Created by 陳加升 on 2025/12/5.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack(spacing: 30) {
            Text("SpaceWar")
                .font(.system(size: 60))
                .bold()

            Text("Vision Pro Survivor Game")
                .font(.title2)

            Button("Start Game") {
                Task {
                    await openImmersiveSpace(id: "GameSpace")
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            VStack(alignment: .leading, spacing: 10) {
                Text("Instructions:")
                    .font(.headline)

                Text("• Use right hand pinch to move your spaceship")
                Text("• Survive for 30 minutes")
                Text("• Collect XP to level up")
                Text("• Choose upgrades to become stronger")
            }
            .font(.subheadline)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
        }
        .padding(40)
    }
}

#Preview {
    ContentView()
        .environment(GameState())
}

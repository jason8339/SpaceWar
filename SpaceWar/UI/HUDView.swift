//
//  HUDView.swift
//  SpaceWar
//
//  遊戲 HUD（血量、等級、時間等）
//

import SwiftUI

struct HUDView: View {

    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    // 血量條
                    HStack {
                        Text("HP:")
                            .font(.headline)
                        ProgressView(value: gameState.playerShip.currentHP, total: gameState.playerShip.maxHP)
                            .frame(width: 200)
                        Text("\(Int(gameState.playerShip.currentHP))/\(Int(gameState.playerShip.maxHP))")
                            .font(.caption)
                    }

                    // 等級與經驗值
                    HStack {
                        Text("Lv.\(gameState.currentLevel)")
                            .font(.headline)
                        ProgressView(value: gameState.currentXP, total: gameState.xpToNextLevel)
                            .frame(width: 200)
                        Text("\(Int(gameState.currentXP))/\(Int(gameState.xpToNextLevel))")
                            .font(.caption)
                    }

                    // 遊戲時間
                    Text("Time: \(String(format: "%02d:%02d", gameState.survivedMinutes, gameState.survivedSeconds))")
                        .font(.headline)

                    // 零件數量
                    Text("Parts: \(gameState.playerShip.shipPartCount)")
                        .font(.subheadline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)

                Spacer()
            }

            Spacer()
        }
        .padding()
    }
}

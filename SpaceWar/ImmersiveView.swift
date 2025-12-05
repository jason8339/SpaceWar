//
//  ImmersiveView.swift
//  SpaceWar
//
//  沉浸式遊戲視圖
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {

    @Environment(GameState.self) private var gameState
    @State private var gameLoopManager: GameLoopManager?

    var body: some View {
        ZStack {
            // AR 場景
            ARImmersiveScene()

            // HUD 覆蓋層
            if gameState.phase == .playing {
                HUDView()
            }

            // 升級選單
            if gameState.phase == .levelUpSelection {
                LevelUpSelectionView()
            }

            // 暫停選單
            if gameState.phase == .paused {
                PauseMenu()
            }

            // 勝利畫面
            if gameState.phase == .victory {
                VictoryView()
            }

            // 失敗畫面
            if gameState.phase == .defeat {
                DefeatView()
            }
        }
        .onAppear {
            setupGame()
        }
        .task {
            await runGameLoop()
        }
    }

    // MARK: - 遊戲設定
    private func setupGame() {
        let difficultyManager = DifficultyManager()
        gameLoopManager = GameLoopManager(gameState: gameState, difficultyManager: difficultyManager)

        // 給玩家初始武器
        gameState.playerShip.addWeapon(PlayerWeapon_SpaceCannon())

        gameState.startGame()
    }

    // MARK: - 遊戲主迴圈
    private func runGameLoop() async {
        while true {
            gameLoopManager?.update()

            // 自動回血
            gameState.playerShip.applyAutoRegen(deltaTime: 1.0/60.0)

            try? await Task.sleep(nanoseconds: 16_666_667)  // ~60 FPS
        }
    }
}

// MARK: - 勝利畫面
struct VictoryView: View {
    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack(spacing: 20) {
            Text("Victory!")
                .font(.system(size: 60))
                .bold()

            Text("You survived 30 minutes!")
                .font(.title)

            Button("Play Again") {
                gameState.startGame()
            }
            .buttonStyle(.bordered)
        }
        .padding(40)
        .background(.regularMaterial)
        .cornerRadius(20)
    }
}

// MARK: - 失敗畫面
struct DefeatView: View {
    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack(spacing: 20) {
            Text("Defeat")
                .font(.system(size: 60))
                .bold()

            Text("Survived: \(String(format: "%02d:%02d", gameState.survivedMinutes, gameState.survivedSeconds))")
                .font(.title)

            Button("Try Again") {
                gameState.startGame()
            }
            .buttonStyle(.bordered)
        }
        .padding(40)
        .background(.regularMaterial)
        .cornerRadius(20)
    }
}

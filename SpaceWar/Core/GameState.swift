//
//  GameState.swift
//  SpaceWar
//
//  遊戲整體狀態管理
//

import Foundation

enum GamePhase {
    case notStarted
    case playing
    case paused
    case levelUpSelection
    case victory
    case defeat
}

@Observable
class GameState {

    // MARK: - 遊戲階段
    var phase: GamePhase = .notStarted

    // MARK: - 時間
    var elapsedTime: Double = 0.0
    var survivedMinutes: Int {
        return Int(elapsedTime / 60.0)
    }
    var survivedSeconds: Int {
        return Int(elapsedTime.truncatingRemainder(dividingBy: 60.0))
    }

    // MARK: - 玩家
    var playerShip: PlayerShip

    // MARK: - 敵人
    var enemies: [EnemyBase] = []

    // MARK: - 子彈
    var bullets: [Bullet] = []

    // MARK: - 掉落物
    var xpOrbs: [ExperienceOrb] = []
    var shipParts: [ShipPartDrop] = []

    // MARK: - 等級與經驗
    var currentLevel: Int = 1
    var currentXP: Double = 0.0
    var xpToNextLevel: Double {
        return GameConfig.baseXPToLevelUp * pow(GameConfig.xpScalingFactor, Double(currentLevel - 1))
    }

    // MARK: - 初始化
    init() {
        self.playerShip = PlayerShip()
    }

    // MARK: - 遊戲控制
    func startGame() {
        reset()
        phase = .playing
    }

    func pauseGame() {
        if phase == .playing {
            phase = .paused
        }
    }

    func resumeGame() {
        if phase == .paused {
            phase = .playing
        }
    }

    func showLevelUpSelection() {
        phase = .levelUpSelection
    }

    func finishLevelUpSelection() {
        phase = .playing
    }

    func victory() {
        phase = .victory
    }

    func defeat() {
        phase = .defeat
    }

    func reset() {
        elapsedTime = 0.0
        enemies.removeAll()
        bullets.removeAll()
        xpOrbs.removeAll()
        shipParts.removeAll()
        currentLevel = 1
        currentXP = 0.0
        playerShip.reset()
        phase = .notStarted
    }

    // MARK: - 經驗值
    func gainXP(amount: Double) {
        currentXP += amount
        while currentXP >= xpToNextLevel {
            currentXP -= xpToNextLevel
            levelUp()
        }
    }

    private func levelUp() {
        currentLevel += 1
        showLevelUpSelection()
    }

    // MARK: - 檢查勝利/失敗
    func checkVictoryDefeat() {
        if elapsedTime >= GameConfig.victoryTimeSeconds {
            victory()
        }
        if playerShip.currentHP <= 0 {
            defeat()
        }
    }
}

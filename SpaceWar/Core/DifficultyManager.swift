//
//  DifficultyManager.swift
//  SpaceWar
//
//  根據遊戲時間動態調整難度
//

import Foundation

@Observable
class DifficultyManager {

    private var elapsedTime: Double = 0.0

    // MARK: - 計算出的倍率
    var enemyHPMultiplier: Double {
        return 1.0 + elapsedTime * GameConfig.enemyHPScalePerSecond
    }

    var enemySpeedMultiplier: Double {
        return 1.0 + elapsedTime * GameConfig.enemySpeedScalePerSecond
    }

    var xpMultiplier: Double {
        return 1.0 + elapsedTime * GameConfig.xpScalePerSecond
    }

    var dropMultiplier: Double {
        return 1.0 + elapsedTime * GameConfig.dropScalePerSecond
    }

    var currentLargeEnemySpawnInterval: Double {
        let interval = GameConfig.largeEnemySpawnIntervalSeconds - elapsedTime / 60.0
        return max(interval, GameConfig.largeEnemyMinIntervalSeconds)
    }

    // MARK: - 更新
    func update(elapsedTime: Double) {
        self.elapsedTime = elapsedTime
    }

    // MARK: - 重置
    func reset() {
        elapsedTime = 0.0
    }
}

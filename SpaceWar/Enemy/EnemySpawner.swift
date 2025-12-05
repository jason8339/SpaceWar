//
//  EnemySpawner.swift
//  SpaceWar
//
//  敵人生成器（360° 無死角生成）
//

import Foundation

class EnemySpawner {

    private let gameState: GameState
    private let difficultyManager: DifficultyManager

    private var smallEnemySpawnAccumulator: Double = 0.0
    private var largeEnemySpawnTimer: Double = 0.0

    init(gameState: GameState, difficultyManager: DifficultyManager) {
        self.gameState = gameState
        self.difficultyManager = difficultyManager
    }

    // MARK: - 更新
    func update(deltaTime: TimeInterval) {
        spawnSmallEnemies(deltaTime: deltaTime)
        spawnLargeEnemies(deltaTime: deltaTime)
    }

    // MARK: - 生成小太空船
    private func spawnSmallEnemies(deltaTime: TimeInterval) {
        smallEnemySpawnAccumulator += deltaTime * GameConfig.smallEnemySpawnPerSecond

        while smallEnemySpawnAccumulator >= 1.0 {
            spawnSmallEnemy()
            smallEnemySpawnAccumulator -= 1.0
        }
    }

    private func spawnSmallEnemy() {
        let position = getRandomSpawnPosition()
        let enemy = EnemySmall(position: position, difficultyMultiplier: difficultyManager)
        gameState.enemies.append(enemy)
    }

    // MARK: - 生成大太空船
    private func spawnLargeEnemies(deltaTime: TimeInterval) {
        largeEnemySpawnTimer += deltaTime

        if largeEnemySpawnTimer >= difficultyManager.currentLargeEnemySpawnInterval {
            spawnLargeEnemy()
            largeEnemySpawnTimer = 0.0
        }
    }

    private func spawnLargeEnemy() {
        let position = getRandomSpawnPosition()
        let enemy = EnemyLarge(position: position, difficultyMultiplier: difficultyManager)
        gameState.enemies.append(enemy)
    }

    // MARK: - 隨機生成位置（360° 球面）
    private func getRandomSpawnPosition() -> SIMD3<Float> {
        let playerPos = gameState.playerShip.position
        var attempts = 0
        let maxAttempts = 10

        while attempts < maxAttempts {
            // 隨機球面角度
            let theta = Float.random(in: 0...(2 * Float.pi))  // 水平角度
            let phi = Float.random(in: 0...Float.pi)  // 垂直角度

            // 隨機半徑
            let radius = Float.random(in: GameConfig.enemySpawnRadiusMin...GameConfig.enemySpawnRadiusMax)

            // 轉換為笛卡爾坐標
            let x = radius * sin(phi) * cos(theta)
            let y = radius * cos(phi)
            let z = radius * sin(phi) * sin(theta)

            let spawnPos = playerPos + SIMD3<Float>(x, y, z)

            // 檢查是否太靠近玩家
            let distanceToPlayer = distance(spawnPos, playerPos)
            if distanceToPlayer >= GameConfig.enemySpawnMinDistanceFromPlayer {
                return spawnPos
            }

            attempts += 1
        }

        // 如果多次嘗試失敗，返回一個保證不太近的位置
        return playerPos + SIMD3<Float>(GameConfig.enemySpawnRadiusMin, 0, 0)
    }

    // MARK: - 重置
    func reset() {
        smallEnemySpawnAccumulator = 0.0
        largeEnemySpawnTimer = 0.0
    }
}

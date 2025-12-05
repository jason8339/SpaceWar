//
//  GameLoopManager.swift
//  SpaceWar
//
//  遊戲主要更新迴圈
//

import Foundation

class GameLoopManager {

    private let gameState: GameState
    private let difficultyManager: DifficultyManager
    private let enemySpawner: EnemySpawner
    private let collisionSystem: CollisionSystem
    private let pickupSystem: PickupSystem
    private let damageSystem: DamageSystem

    private var lastUpdateTime: Date?

    init(gameState: GameState, difficultyManager: DifficultyManager) {
        self.gameState = gameState
        self.difficultyManager = difficultyManager
        self.enemySpawner = EnemySpawner(gameState: gameState, difficultyManager: difficultyManager)
        self.collisionSystem = CollisionSystem(gameState: gameState)
        self.pickupSystem = PickupSystem(gameState: gameState)
        self.damageSystem = DamageSystem()
    }

    // MARK: - 主更新函數
    func update() {
        guard gameState.phase == .playing else { return }

        let now = Date()
        let deltaTime: TimeInterval
        if let last = lastUpdateTime {
            deltaTime = now.timeIntervalSince(last)
        } else {
            deltaTime = 1.0 / 60.0  // 第一幀假設 60 FPS
        }
        lastUpdateTime = now

        // 1. 更新遊戲時間
        gameState.elapsedTime += deltaTime

        // 2. 更新難度管理器
        difficultyManager.update(elapsedTime: gameState.elapsedTime)

        // 3. 更新玩家武器（自動攻擊）
        updatePlayerWeapons(deltaTime: deltaTime)

        // 4. 更新敵人
        updateEnemies(deltaTime: deltaTime)

        // 5. 更新子彈
        updateBullets(deltaTime: deltaTime)

        // 6. 生成敵人
        enemySpawner.update(deltaTime: deltaTime)

        // 7. 碰撞檢測
        collisionSystem.checkCollisions(damageSystem: damageSystem, difficultyManager: difficultyManager)

        // 8. 更新掉落物吸收
        pickupSystem.update(deltaTime: deltaTime)

        // 9. 檢查勝利/失敗
        gameState.checkVictoryDefeat()
    }

    // MARK: - 更新玩家武器
    private func updatePlayerWeapons(deltaTime: TimeInterval) {
        let context = WeaponContext(
            playerPosition: gameState.playerShip.position,
            enemies: gameState.enemies,
            gameState: gameState,
            difficultyManager: difficultyManager
        )

        for weapon in gameState.playerShip.weapons {
            weapon.update(deltaTime: deltaTime, context: context)
        }
    }

    // MARK: - 更新敵人
    private func updateEnemies(deltaTime: TimeInterval) {
        for enemy in gameState.enemies {
            enemy.update(deltaTime: deltaTime, playerPosition: gameState.playerShip.position)
        }
    }

    // MARK: - 更新子彈
    private func updateBullets(deltaTime: TimeInterval) {
        var bulletsToRemove: [Int] = []

        for (index, bullet) in gameState.bullets.enumerated() {
            bullet.update(deltaTime: deltaTime)

            // 檢查是否超時或超出範圍
            if bullet.shouldRemove {
                bulletsToRemove.append(index)
            }
        }

        // 移除過期子彈
        for index in bulletsToRemove.reversed() {
            gameState.bullets.remove(at: index)
        }
    }

    // MARK: - 重置
    func reset() {
        lastUpdateTime = nil
        enemySpawner.reset()
    }
}

//
//  CollisionSystem.swift
//  SpaceWar
//
//  碰撞檢測系統
//

import Foundation

class CollisionSystem {

    private let gameState: GameState

    init(gameState: GameState) {
        self.gameState = gameState
    }

    // MARK: - 主要碰撞檢查
    func checkCollisions(damageSystem: DamageSystem, difficultyManager: DifficultyManager) {
        checkBulletEnemyCollisions(damageSystem: damageSystem)
        checkEnemyPlayerCollisions()
        removeDeadEnemies()
    }

    // MARK: - 子彈 vs 敵人
    private func checkBulletEnemyCollisions(damageSystem: DamageSystem) {
        var bulletsToRemove: Set<Int> = []

        for (bulletIndex, bullet) in gameState.bullets.enumerated() {
            for enemy in gameState.enemies {
                if enemy.isDead { continue }

                let dist = distance(bullet.position, enemy.position)
                let collisionDist = bullet.radius + enemy.collisionRadius

                if dist <= collisionDist {
                    // 命中
                    damageSystem.applyDamageToEnemy(
                        enemy: enemy,
                        baseDamage: bullet.damage,
                        playerStats: gameState.playerShip.stats
                    )

                    bullet.hitEnemy()

                    if bullet.penetrationCount < 0 {
                        bulletsToRemove.insert(bulletIndex)
                    }

                    break  // 這顆子彈已經命中一個敵人
                }
            }
        }

        // 移除用盡穿透的子彈
        for index in bulletsToRemove.sorted(by: >) {
            gameState.bullets.remove(at: index)
        }
    }

    // MARK: - 敵人 vs 玩家
    private func checkEnemyPlayerCollisions() {
        let playerPos = gameState.playerShip.position
        let playerRadius = GameConfig.playerCollisionRadius

        for enemy in gameState.enemies {
            if enemy.isDead { continue }

            let dist = distance(enemy.position, playerPos)
            let collisionDist = enemy.collisionRadius + playerRadius

            if dist <= collisionDist {
                // 玩家受到接觸傷害
                gameState.playerShip.takeDamage(amount: enemy.contactDamage)
            }
        }
    }

    // MARK: - 移除死亡敵人並生成掉落物
    private func removeDeadEnemies() {
        var enemiesToRemove: [Int] = []

        for (index, enemy) in gameState.enemies.enumerated() {
            if enemy.isDead {
                let (xp, parts) = enemy.onDeath()

                // 生成 XP orb
                let xpOrb = ExperienceOrb(position: enemy.position, xpAmount: xp)
                gameState.xpOrbs.append(xpOrb)

                // 生成零件
                if parts > 0 {
                    let shipPart = ShipPartDrop(position: enemy.position, partCount: parts)
                    gameState.shipParts.append(shipPart)
                }

                enemiesToRemove.append(index)
            }
        }

        for index in enemiesToRemove.reversed() {
            gameState.enemies.remove(at: index)
        }
    }
}

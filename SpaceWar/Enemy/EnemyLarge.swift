//
//  EnemyLarge.swift
//  SpaceWar
//
//  大太空船（Mini Boss）
//

import Foundation

class EnemyLarge: EnemyBase {

    private let dropMultiplier: Double

    init(position: SIMD3<Float>, difficultyMultiplier: DifficultyManager) {
        let hp = GameConfig.enemyLargeBaseHP * difficultyMultiplier.enemyHPMultiplier
        let speed = GameConfig.enemyLargeBaseMoveSpeed * Float(difficultyMultiplier.enemySpeedMultiplier)
        let xp = GameConfig.enemyLargeBaseXP * difficultyMultiplier.xpMultiplier

        self.dropMultiplier = difficultyMultiplier.dropMultiplier

        super.init(
            position: position,
            maxHP: hp,
            moveSpeed: speed,
            collisionRadius: GameConfig.enemyLargeCollisionRadius,
            xpValue: xp,
            contactDamage: GameConfig.enemyLargeBaseContactDamage
        )
    }

    override func onDeath() -> (xp: Double, shipParts: Int) {
        let baseParts = Int.random(in: GameConfig.enemyLargeDropPartMin...GameConfig.enemyLargeDropPartMax)
        let finalParts = Int(Double(baseParts) * dropMultiplier)
        return (xpValue, max(finalParts, 1))
    }
}

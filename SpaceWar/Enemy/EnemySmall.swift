//
//  EnemySmall.swift
//  SpaceWar
//
//  小太空船
//

import Foundation

class EnemySmall: EnemyBase {

    init(position: SIMD3<Float>, difficultyMultiplier: DifficultyManager) {
        let hp = GameConfig.enemySmallBaseHP * difficultyMultiplier.enemyHPMultiplier
        let speed = GameConfig.enemySmallBaseMoveSpeed * Float(difficultyMultiplier.enemySpeedMultiplier)
        let xp = GameConfig.enemySmallBaseXP * difficultyMultiplier.xpMultiplier

        super.init(
            position: position,
            maxHP: hp,
            moveSpeed: speed,
            collisionRadius: GameConfig.enemySmallCollisionRadius,
            xpValue: xp,
            contactDamage: GameConfig.enemySmallBaseContactDamage
        )
    }

    override func onDeath() -> (xp: Double, shipParts: Int) {
        let dropPart = Double.random(in: 0...1) < GameConfig.enemySmallDropPartChance ? 1 : 0
        return (xpValue, dropPart)
    }
}

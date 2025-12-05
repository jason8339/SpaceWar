//
//  PlayerWeapon_ElectroField.swift
//  SpaceWar
//
//  電磁牆 - 玩家周圍持續傷害範圍
//

import Foundation

class PlayerWeapon_ElectroField: PlayerWeapon {

    let weaponName = "Electromagnetic Wall"
    var level: Int = 1

    private var damageAccumulator: Double = 0.0

    var currentRadius: Float {
        return GameConfig.electroFieldBaseRadius * (1.0 + Float(level) * 0.2)
    }

    var dps: Double {
        return GameConfig.electroFieldBaseDPS * Double(level) * 0.5
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        damageAccumulator += deltaTime

        // 每 0.1 秒造成一次傷害
        if damageAccumulator >= 0.1 {
            applyDamage(context: context, deltaTime: damageAccumulator)
            damageAccumulator = 0.0
        }
    }

    private func applyDamage(context: WeaponContext, deltaTime: Double) {
        let damage = dps * deltaTime

        for enemy in context.enemies {
            let dist = distance(enemy.position, context.playerPosition)
            if dist <= currentRadius {
                enemy.takeDamage(amount: damage)
            }
        }
    }

    func levelUp() {
        level += 1
    }
}

//
//  PlayerWeapon_PulseShockwave.swift
//  SpaceWar
//
//  脈衝震波 - 推開並傷害附近敵人（防禦技能）
//

import Foundation

class PlayerWeapon_PulseShockwave: PlayerWeapon {

    let weaponName = "Pulse Shockwave"
    var level: Int = 1

    private var cooldownTimer: Double = 0.0

    var cooldown: Double {
        return GameConfig.pulseShockwaveCooldown
    }

    var radius: Float {
        return GameConfig.pulseShockwaveRadius * (1.0 + Float(level) * 0.2)
    }

    var damage: Double {
        return GameConfig.pulseShockwaveBaseDamage * Double(level) * 0.5
    }

    var knockbackForce: Float {
        return GameConfig.pulseShockwaveKnockbackForce * (1.0 + Float(level) * 0.2)
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        cooldownTimer += deltaTime

        if cooldownTimer >= cooldown {
            triggerShockwave(context: context)
            cooldownTimer = 0.0
        }
    }

    private func triggerShockwave(context: WeaponContext) {
        for enemy in context.enemies {
            let dist = distance(enemy.position, context.playerPosition)

            if dist <= radius {
                // 造成傷害
                enemy.takeDamage(amount: damage)

                // 推開敵人
                if dist > 0.1 {  // 避免除以 0
                    let direction = normalize(enemy.position - context.playerPosition)
                    let knockback = direction * knockbackForce
                    enemy.position += knockback
                }
            }
        }
    }

    func levelUp() {
        level += 1
    }
}

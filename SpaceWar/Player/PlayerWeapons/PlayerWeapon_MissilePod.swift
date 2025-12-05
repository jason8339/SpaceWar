//
//  PlayerWeapon_MissilePod.swift
//  SpaceWar
//
//  反應彈匣 - 自動鎖定追蹤飛彈
//

import Foundation

class PlayerWeapon_MissilePod: PlayerWeapon {

    let weaponName = "Reactor Missile Pod"
    var level: Int = 1

    private var cooldownTimer: Double = 0.0

    var cooldown: Double {
        return GameConfig.missilePodCooldown
    }

    var missileCount: Int {
        return GameConfig.missilePodMissileCount + level - 1
    }

    var damage: Double {
        return GameConfig.missilePodBaseDamage * Double(level) * 0.5
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        cooldownTimer += deltaTime

        if cooldownTimer >= cooldown {
            fireMissiles(context: context)
            cooldownTimer = 0.0
        }
    }

    private func fireMissiles(context: WeaponContext) {
        let targets = findNearestEnemies(context: context, count: missileCount)

        for target in targets {
            let direction = normalize(target.position - context.playerPosition)

            // 飛彈用子彈模擬（實際上應該有追蹤邏輯，這裡簡化）
            let missile = Bullet(
                position: context.playerPosition,
                direction: direction,
                speed: GameConfig.missilePodMissileSpeed,
                damage: damage,
                penetration: 0,  // 飛彈不穿透
                radius: 0.1
            )

            context.gameState.bullets.append(missile)
        }
    }

    private func findNearestEnemies(context: WeaponContext, count: Int) -> [EnemyBase] {
        let sorted = context.enemies.sorted { a, b in
            let distA = distance(a.position, context.playerPosition)
            let distB = distance(b.position, context.playerPosition)
            return distA < distB
        }

        return Array(sorted.prefix(count))
    }

    func levelUp() {
        level += 1
    }
}

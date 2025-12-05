//
//  PlayerWeapon_LaserBeam.swift
//  SpaceWar
//
//  雙軌雷射 - 週期性發射穿透雷射
//

import Foundation

class PlayerWeapon_LaserBeam: PlayerWeapon {

    let weaponName = "Dual Rail Laser"
    var level: Int = 1

    private var cooldownTimer: Double = 0.0

    var cooldown: Double {
        return GameConfig.laserBeamCooldown  // 可以被被動減少
    }

    var damage: Double {
        return GameConfig.laserBeamBaseDPS * Double(level) * 0.5
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        cooldownTimer += deltaTime

        if cooldownTimer >= cooldown {
            fireLasers(context: context)
            cooldownTimer = 0.0
        }
    }

    private func fireLasers(context: WeaponContext) {
        guard let targetEnemy = findNearestEnemy(context: context) else { return }

        let direction = normalize(targetEnemy.position - context.playerPosition)

        // 計算兩條平行雷射的位置
        let perpendicular = cross(direction, SIMD3<Float>(0, 1, 0))
        let offset = normalize(perpendicular) * GameConfig.laserBeamSeparation

        let position1 = context.playerPosition + offset
        let position2 = context.playerPosition - offset

        // 發射兩條雷射（用子彈模擬）
        let penetration = GameConfig.laserBeamBasePenetration + context.gameState.playerShip.stats.piercingCount

        let laser1 = Bullet(
            position: position1,
            direction: direction,
            speed: 20.0,  // 雷射速度很快
            damage: damage,
            penetration: penetration,
            radius: 0.05
        )

        let laser2 = Bullet(
            position: position2,
            direction: direction,
            speed: 20.0,
            damage: damage,
            penetration: penetration,
            radius: 0.05
        )

        context.gameState.bullets.append(laser1)
        context.gameState.bullets.append(laser2)
    }

    private func findNearestEnemy(context: WeaponContext) -> EnemyBase? {
        return context.enemies.min(by: { a, b in
            let distA = distance(a.position, context.playerPosition)
            let distB = distance(b.position, context.playerPosition)
            return distA < distB
        })
    }

    func levelUp() {
        level += 1
    }
}

//
//  PlayerWeapon_SpaceCannon.swift
//  SpaceWar
//
//  太空炮 - 基礎直線射擊武器
//

import Foundation

class PlayerWeapon_SpaceCannon: PlayerWeapon {

    let weaponName = "Space Cannon"
    var level: Int = 1

    private var timeSinceLastShot: Double = 0.0
    private var fireInterval: Double {
        return 1.0 / (GameConfig.spaceCannonBaseFireRate * Double(level) * 0.5)
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        timeSinceLastShot += deltaTime

        if timeSinceLastShot >= fireInterval {
            fire(context: context)
            timeSinceLastShot = 0.0
        }
    }

    private func fire(context: WeaponContext) {
        guard let nearestEnemy = findNearestEnemy(context: context) else { return }

        let direction = normalize(nearestEnemy.position - context.playerPosition)
        let damage = GameConfig.spaceCannonBaseDamage * Double(level) * 0.5
        let penetration = GameConfig.spaceCannonBasePenetration + context.gameState.playerShip.stats.piercingCount

        // 支援 multi-shot
        let multiShotCount = context.gameState.playerShip.stats.multiShotCount
        let angleSpread: Float = 0.1  // 弧度

        for i in 0..<multiShotCount {
            var bulletDirection = direction

            if multiShotCount > 1 {
                let offset = Float(i - multiShotCount / 2) * angleSpread
                bulletDirection = rotateVectorY(direction, angle: offset)
            }

            let bullet = Bullet(
                position: context.playerPosition,
                direction: bulletDirection,
                speed: GameConfig.spaceCannonBulletSpeed * Float(context.gameState.playerShip.stats.bulletSpeedMultiplier),
                damage: damage,
                penetration: penetration,
                radius: GameConfig.bulletBaseRadius * Float(context.gameState.playerShip.stats.bulletSizeMultiplier)
            )

            context.gameState.bullets.append(bullet)
        }
    }

    private func findNearestEnemy(context: WeaponContext) -> EnemyBase? {
        return context.enemies.min(by: { a, b in
            let distA = distance(a.position, context.playerPosition)
            let distB = distance(b.position, context.playerPosition)
            return distA < distB
        })
    }

    private func rotateVectorY(_ vector: SIMD3<Float>, angle: Float) -> SIMD3<Float> {
        let cosA = cos(angle)
        let sinA = sin(angle)
        return SIMD3<Float>(
            vector.x * cosA - vector.z * sinA,
            vector.y,
            vector.x * sinA + vector.z * cosA
        )
    }

    func levelUp() {
        level += 1
    }
}

//
//  PlayerWeapon_PhotonRing.swift
//  SpaceWar
//
//  光子刀環 - 環繞玩家旋轉的能量刀
//

import Foundation

class PlayerWeapon_PhotonRing: PlayerWeapon {

    let weaponName = "Photon Blade Ring"
    var level: Int = 1

    private var rotationAngle: Float = 0.0
    private var damageAccumulator: Double = 0.0

    var bladeCount: Int {
        return GameConfig.photonRingBladeCount + level - 1
    }

    var radius: Float {
        return GameConfig.photonRingRadius * (1.0 + Float(level) * 0.1)
    }

    var dps: Double {
        return GameConfig.photonRingBaseDPS * Double(level) * 0.5
    }

    func update(deltaTime: TimeInterval, context: WeaponContext) {
        // 更新旋轉角度
        rotationAngle += GameConfig.photonRingRotationSpeed * Float(deltaTime)
        if rotationAngle > 2 * Float.pi {
            rotationAngle -= 2 * Float.pi
        }

        damageAccumulator += deltaTime

        // 每 0.1 秒檢查碰撞
        if damageAccumulator >= 0.1 {
            checkCollisions(context: context, deltaTime: damageAccumulator)
            damageAccumulator = 0.0
        }
    }

    private func checkCollisions(context: WeaponContext, deltaTime: Double) {
        let bladePositions = getBladePositions(playerPosition: context.playerPosition)
        let damage = dps * deltaTime

        for enemy in context.enemies {
            for bladePos in bladePositions {
                let dist = distance(enemy.position, bladePos)
                if dist < 0.2 {  // 刀環碰撞半徑
                    enemy.takeDamage(amount: damage)
                    break  // 每個敵人每次只受到一次傷害
                }
            }
        }
    }

    private func getBladePositions(playerPosition: SIMD3<Float>) -> [SIMD3<Float>] {
        var positions: [SIMD3<Float>] = []

        for i in 0..<bladeCount {
            let angle = rotationAngle + Float(i) * (2 * Float.pi / Float(bladeCount))
            let x = cos(angle) * radius
            let z = sin(angle) * radius

            let bladePos = playerPosition + SIMD3<Float>(x, 0, z)
            positions.append(bladePos)
        }

        return positions
    }

    func levelUp() {
        level += 1
    }
}

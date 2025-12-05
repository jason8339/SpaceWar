//
//  EnemyBase.swift
//  SpaceWar
//
//  敵人基礎類別
//

import Foundation
import RealityKit

class EnemyBase {

    // MARK: - 屬性
    var position: SIMD3<Float>
    var currentHP: Double
    var maxHP: Double
    var moveSpeed: Float
    var collisionRadius: Float
    var xpValue: Double
    var contactDamage: Double

    var isDead: Bool {
        return currentHP <= 0
    }

    // MARK: - 初始化
    init(position: SIMD3<Float>, maxHP: Double, moveSpeed: Float, collisionRadius: Float, xpValue: Double, contactDamage: Double) {
        self.position = position
        self.currentHP = maxHP
        self.maxHP = maxHP
        self.moveSpeed = moveSpeed
        self.collisionRadius = collisionRadius
        self.xpValue = xpValue
        self.contactDamage = contactDamage
    }

    // MARK: - 更新
    func update(deltaTime: TimeInterval, playerPosition: SIMD3<Float>) {
        // 永遠朝玩家移動
        let direction = normalize(playerPosition - position)
        let movement = direction * moveSpeed * Float(deltaTime)
        position += movement
    }

    // MARK: - 受到傷害
    func takeDamage(amount: Double) {
        currentHP -= amount
        if currentHP < 0 {
            currentHP = 0
        }
    }

    // MARK: - 死亡時的掉落（由子類別覆寫或在 Spawner 處理）
    func onDeath() -> (xp: Double, shipParts: Int) {
        return (xpValue, 0)
    }
}

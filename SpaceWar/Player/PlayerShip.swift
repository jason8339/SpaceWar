//
//  PlayerShip.swift
//  SpaceWar
//
//  玩家太空船（玩家本人就是這艘太空船）
//

import Foundation
import RealityKit

@Observable
class PlayerShip {

    // MARK: - 位置與移動
    var position: SIMD3<Float> = [0, 1.5, -2]  // 預設在玩家前方
    var velocity: SIMD3<Float> = [0, 0, 0]

    // MARK: - 生命值
    var currentHP: Double
    var maxHP: Double {
        return stats.getFinalMaxHP()
    }

    // MARK: - 屬性
    let stats = PlayerStats()

    // MARK: - 武器與被動
    var weapons: [PlayerWeapon] = []
    var passives: [PlayerPassive] = []

    // MARK: - 經驗值與零件
    var shipPartCount: Int = 0

    // MARK: - 移動速度
    var moveSpeed: Float {
        return stats.getFinalMoveSpeed()
    }

    var pickupRange: Float {
        return stats.getFinalPickupRange()
    }

    // MARK: - 初始化
    init() {
        self.currentHP = GameConfig.playerBaseMaxHP
    }

    // MARK: - 傷害與治療
    func takeDamage(amount: Double) {
        currentHP -= amount
        if currentHP < 0 {
            currentHP = 0
        }
    }

    func heal(amount: Double) {
        currentHP += amount
        if currentHP > maxHP {
            currentHP = maxHP
        }
    }

    // MARK: - 自動回血
    func applyAutoRegen(deltaTime: TimeInterval) {
        if stats.autoRegenPerSecond > 0 {
            heal(amount: stats.autoRegenPerSecond * deltaTime)
        }
    }

    // MARK: - 零件
    func gainShipParts(count: Int) {
        shipPartCount += count
    }

    // MARK: - 武器與被動管理
    func addWeapon(_ weapon: PlayerWeapon) {
        weapons.append(weapon)
    }

    func addPassive(_ passive: PlayerPassive) {
        passives.append(passive)
        applyPassiveEffects()
    }

    func applyPassiveEffects() {
        // 重置 stats
        stats.reset()

        // 套用所有被動效果
        for passive in passives {
            passive.apply(to: &stats)
        }

        // 確保 HP 不超過新的最大值
        if currentHP > maxHP {
            currentHP = maxHP
        }
    }

    // MARK: - 移動
    func move(direction: SIMD3<Float>, speed: Float, deltaTime: TimeInterval) {
        let normalizedDir = normalize(direction)
        let movement = normalizedDir * speed * Float(deltaTime)
        position += movement
    }

    // MARK: - 重置
    func reset() {
        position = [0, 1.5, -2]
        velocity = [0, 0, 0]
        currentHP = GameConfig.playerBaseMaxHP
        stats.reset()
        weapons.removeAll()
        passives.removeAll()
        shipPartCount = 0
    }
}

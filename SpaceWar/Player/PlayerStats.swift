//
//  PlayerStats.swift
//  SpaceWar
//
//  玩家可成長屬性
//

import Foundation

class PlayerStats {

    // MARK: - 屬性倍率
    var maxHPMultiplier: Double = 1.0
    var damageMultiplier: Double = 1.0
    var moveSpeedMultiplier: Double = 1.0
    var bulletSizeMultiplier: Double = 1.0
    var bulletSpeedMultiplier: Double = 1.0
    var pickupRangeMultiplier: Double = 1.0
    var cooldownReductionMultiplier: Double = 1.0  // 0.9 = 減少 10% 冷卻
    var autoRegenPerSecond: Double = 0.0
    var critChance: Double = 0.0  // 0.0 ~ 1.0
    var critDamageMultiplier: Double = 2.0  // 暴擊傷害倍率

    // MARK: - 子彈屬性
    var multiShotCount: Int = 1  // 同時射出子彈數量
    var piercingCount: Int = 0  // 額外穿透數量

    // MARK: - 計算最終數值
    func getFinalMaxHP() -> Double {
        return GameConfig.playerBaseMaxHP * maxHPMultiplier
    }

    func getFinalMoveSpeed() -> Float {
        return GameConfig.playerBaseMoveSpeed * Float(moveSpeedMultiplier)
    }

    func getFinalPickupRange() -> Float {
        return GameConfig.playerBasePickupRange * Float(pickupRangeMultiplier)
    }

    func getFinalBulletDamage() -> Double {
        return GameConfig.playerBaseBulletDamage * damageMultiplier
    }

    // MARK: - 暴擊計算
    func rollCritical() -> Bool {
        return Double.random(in: 0...1) < critChance
    }

    // MARK: - 重置
    func reset() {
        maxHPMultiplier = 1.0
        damageMultiplier = 1.0
        moveSpeedMultiplier = 1.0
        bulletSizeMultiplier = 1.0
        bulletSpeedMultiplier = 1.0
        pickupRangeMultiplier = 1.0
        cooldownReductionMultiplier = 1.0
        autoRegenPerSecond = 0.0
        critChance = 0.0
        critDamageMultiplier = 2.0
        multiShotCount = 1
        piercingCount = 0
    }
}

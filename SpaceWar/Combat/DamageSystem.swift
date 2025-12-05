//
//  DamageSystem.swift
//  SpaceWar
//
//  統一傷害計算邏輯
//

import Foundation

class DamageSystem {

    // MARK: - 計算最終傷害
    func calculateDamage(baseDamage: Double, playerStats: PlayerStats, isCritical: Bool = false) -> Double {
        var finalDamage = baseDamage * playerStats.damageMultiplier

        if isCritical {
            finalDamage *= playerStats.critDamageMultiplier
        }

        return finalDamage
    }

    // MARK: - 檢查是否暴擊
    func checkCritical(playerStats: PlayerStats) -> Bool {
        return playerStats.rollCritical()
    }

    // MARK: - 對敵人造成傷害
    func applyDamageToEnemy(enemy: EnemyBase, baseDamage: Double, playerStats: PlayerStats) {
        let isCrit = checkCritical(playerStats: playerStats)
        let finalDamage = calculateDamage(baseDamage: baseDamage, playerStats: playerStats, isCritical: isCrit)
        enemy.takeDamage(amount: finalDamage)
    }
}

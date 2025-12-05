//
//  Passive_CooldownReduction.swift
//  SpaceWar
//
//  Thermal Sync - 降低武器技能冷卻時間
//

import Foundation

class Passive_CooldownReduction: PlayerPassive {

    let passiveName = "Thermal Sync"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.cooldownReductionMultiplier *= (1.0 - Double(level) * 0.08)  // 每級減少 8%
    }

    func levelUp() {
        level += 1
    }
}

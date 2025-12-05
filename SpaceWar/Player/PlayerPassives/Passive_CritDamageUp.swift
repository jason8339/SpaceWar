//
//  Passive_CritDamageUp.swift
//  SpaceWar
//
//  Star Core Fission - 提升暴擊傷害
//

import Foundation

class Passive_CritDamageUp: PlayerPassive {

    let passiveName = "Star Core Fission"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.critDamageMultiplier += Double(level) * 0.5  // 每級 +0.5 倍暴擊傷害
    }

    func levelUp() {
        level += 1
    }
}

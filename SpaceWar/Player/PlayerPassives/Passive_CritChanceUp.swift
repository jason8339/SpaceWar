//
//  Passive_CritChanceUp.swift
//  SpaceWar
//
//  Stellar Surge - 提升暴擊率
//

import Foundation

class Passive_CritChanceUp: PlayerPassive {

    let passiveName = "Stellar Surge"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.critChance += Double(level) * 0.05  // 每級 +5% 暴擊率
    }

    func levelUp() {
        level += 1
    }
}

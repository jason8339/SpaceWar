//
//  Passive_AutoRegen.swift
//  SpaceWar
//
//  Auto-Repair Nanobots - 緩慢回血
//

import Foundation

class Passive_AutoRegen: PlayerPassive {

    let passiveName = "Auto-Repair Nanobots"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.autoRegenPerSecond += Double(level) * 2.0  // 每級每秒回 2 HP
    }

    func levelUp() {
        level += 1
    }
}

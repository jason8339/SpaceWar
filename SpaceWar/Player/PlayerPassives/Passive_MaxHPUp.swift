//
//  Passive_MaxHPUp.swift
//  SpaceWar
//
//  Nano Armor / Quantum Shield - 提升最大血量
//

import Foundation

class Passive_MaxHPUp: PlayerPassive {

    let passiveName = "Nano Armor"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.maxHPMultiplier *= (1.0 + Double(level) * 0.25)
    }

    func levelUp() {
        level += 1
    }
}

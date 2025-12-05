//
//  Passive_PickupRangeUp.swift
//  SpaceWar
//
//  Tractor Field Boost - 提升經驗值/零件吸收範圍（只吸掉落物，不吸敵人）
//

import Foundation

class Passive_PickupRangeUp: PlayerPassive {

    let passiveName = "Tractor Field Boost"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.pickupRangeMultiplier *= (1.0 + Double(level) * 0.30)
    }

    func levelUp() {
        level += 1
    }
}

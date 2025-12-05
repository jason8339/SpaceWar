//
//  Passive_MoveSpeedUp.swift
//  SpaceWar
//
//  Warp Engine - 提升太空船移動速度
//

import Foundation

class Passive_MoveSpeedUp: PlayerPassive {

    let passiveName = "Warp Engine"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.moveSpeedMultiplier *= (1.0 + Double(level) * 0.20)
    }

    func levelUp() {
        level += 1
    }
}

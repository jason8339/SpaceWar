//
//  Passive_MultiShot.swift
//  SpaceWar
//
//  Multi-Shot Matrix - 同時射出多發子彈
//

import Foundation

class Passive_MultiShot: PlayerPassive {

    let passiveName = "Multi-Shot Matrix"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.multiShotCount += level
    }

    func levelUp() {
        level += 1
    }
}

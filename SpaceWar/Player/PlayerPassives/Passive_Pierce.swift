//
//  Passive_Pierce.swift
//  SpaceWar
//
//  Pierce Module - 增加子彈穿透敵人數量
//

import Foundation

class Passive_Pierce: PlayerPassive {

    let passiveName = "Pierce Module"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.piercingCount += level
    }

    func levelUp() {
        level += 1
    }
}

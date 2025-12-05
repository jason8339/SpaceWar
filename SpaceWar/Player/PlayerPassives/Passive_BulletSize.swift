//
//  Passive_BulletSize.swift
//  SpaceWar
//
//  Quantum Expansion - 提升子彈碰撞體積
//

import Foundation

class Passive_BulletSize: PlayerPassive {

    let passiveName = "Quantum Expansion"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.bulletSizeMultiplier *= (1.0 + Double(level) * 0.20)
    }

    func levelUp() {
        level += 1
    }
}

//
//  Passive_BulletSpeed.swift
//  SpaceWar
//
//  Bullet Propulsion - 提升子彈速度
//

import Foundation

class Passive_BulletSpeed: PlayerPassive {

    let passiveName = "Bullet Propulsion"
    var level: Int = 1

    func apply(to stats: inout PlayerStats) {
        stats.bulletSpeedMultiplier *= (1.0 + Double(level) * 0.15)
    }

    func levelUp() {
        level += 1
    }
}

//
//  PlayerPassiveProtocol.swift
//  SpaceWar
//
//  所有被動效果的共用介面
//

import Foundation

protocol PlayerPassive: AnyObject {
    var passiveName: String { get }
    var level: Int { get set }

    func apply(to stats: inout PlayerStats)
    func levelUp()
}

//
//  PlayerWeaponProtocol.swift
//  SpaceWar
//
//  所有玩家武器的共用介面
//

import Foundation

struct WeaponContext {
    let playerPosition: SIMD3<Float>
    let enemies: [EnemyBase]
    let gameState: GameState
    let difficultyManager: DifficultyManager
}

protocol PlayerWeapon: AnyObject {
    var weaponName: String { get }
    var level: Int { get set }

    func update(deltaTime: TimeInterval, context: WeaponContext)
    func levelUp()
}

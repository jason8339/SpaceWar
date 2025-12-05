//
//  ExperienceOrb.swift
//  SpaceWar
//
//  經驗值球
//

import Foundation

class ExperienceOrb {

    var position: SIMD3<Float>
    let xpAmount: Double
    var isAttracted: Bool = false

    init(position: SIMD3<Float>, xpAmount: Double) {
        self.position = position
        self.xpAmount = xpAmount
    }

    // MARK: - 移動向玩家
    func moveTowardsPlayer(playerPosition: SIMD3<Float>, deltaTime: TimeInterval) {
        let direction = normalize(playerPosition - position)
        let movement = direction * GameConfig.xpOrbMagnetSpeed * Float(deltaTime)
        position += movement
    }

    // MARK: - 檢查是否抵達玩家
    func hasReachedPlayer(playerPosition: SIMD3<Float>) -> Bool {
        return distance(position, playerPosition) < 0.3
    }
}

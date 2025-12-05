//
//  ShipPartDrop.swift
//  SpaceWar
//
//  太空船零件掉落物
//

import Foundation

class ShipPartDrop {

    var position: SIMD3<Float>
    let partCount: Int
    var isAttracted: Bool = false

    init(position: SIMD3<Float>, partCount: Int) {
        self.position = position
        self.partCount = partCount
    }

    // MARK: - 移動向玩家
    func moveTowardsPlayer(playerPosition: SIMD3<Float>, deltaTime: TimeInterval) {
        let direction = normalize(playerPosition - position)
        let movement = direction * GameConfig.shipPartMagnetSpeed * Float(deltaTime)
        position += movement
    }

    // MARK: - 檢查是否抵達玩家
    func hasReachedPlayer(playerPosition: SIMD3<Float>) -> Bool {
        return distance(position, playerPosition) < 0.3
    }
}

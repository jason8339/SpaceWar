//
//  Bullet.swift
//  SpaceWar
//
//  子彈
//

import Foundation
import RealityKit

class Bullet {

    // MARK: - 屬性
    var position: SIMD3<Float>
    var direction: SIMD3<Float>
    var speed: Float
    var damage: Double
    var radius: Float
    var penetrationCount: Int  // 剩餘可穿透次數
    var lifeTime: Double
    var traveledDistance: Float = 0.0

    var shouldRemove: Bool {
        return lifeTime <= 0 || penetrationCount < 0 || traveledDistance > GameConfig.bulletMaxDistance
    }

    // MARK: - 初始化
    init(position: SIMD3<Float>, direction: SIMD3<Float>, speed: Float, damage: Double, penetration: Int = 1, radius: Float = GameConfig.bulletBaseRadius) {
        self.position = position
        self.direction = normalize(direction)
        self.speed = speed
        self.damage = damage
        self.penetrationCount = penetration
        self.radius = radius
        self.lifeTime = GameConfig.bulletMaxLifeTime
    }

    // MARK: - 更新
    func update(deltaTime: TimeInterval) {
        let movement = direction * speed * Float(deltaTime)
        position += movement
        traveledDistance += length(movement)
        lifeTime -= deltaTime
    }

    // MARK: - 命中敵人
    func hitEnemy() {
        penetrationCount -= 1
    }
}

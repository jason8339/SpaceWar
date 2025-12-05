//
//  EntityFactory.swift
//  SpaceWar
//
//  建立 RealityKit 實體的工廠類別
//

import Foundation
import RealityKit

class EntityFactory {

    // MARK: - 建立玩家太空船（白色球體）
    static func createPlayerShip() -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: GameConfig.playerCollisionRadius)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    // MARK: - 建立小敵人太空船（紅色球體）
    static func createSmallEnemy() -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: GameConfig.enemySmallCollisionRadius)
        let material = SimpleMaterial(color: .red, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    // MARK: - 建立大敵人太空船（深紅色球體）
    static func createLargeEnemy() -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: GameConfig.enemyLargeCollisionRadius)
        let material = SimpleMaterial(color: .init(red: 0.5, green: 0, blue: 0), isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    // MARK: - 建立子彈（黃色球體）
    static func createBullet(radius: Float) -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: .yellow, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    // MARK: - 建立 XP orb（綠色球體）
    static func createXPOrb() -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: 0.08)
        let material = SimpleMaterial(color: .green, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    // MARK: - 建立零件掉落（藍色立方體）
    static func createShipPart() -> ModelEntity {
        let mesh = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }
}

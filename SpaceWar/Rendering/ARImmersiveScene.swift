//
//  ARImmersiveScene.swift
//  SpaceWar
//
//  AR 沉浸式場景管理
//

import SwiftUI
import RealityKit

struct ARImmersiveScene: View {

    @Environment(GameState.self) private var gameState

    var body: some View {
        RealityView { content in
            // 初始化場景
            setupScene(content: content)
        } update: { content in
            // 每幀更新
            updateScene(content: content)
        }
    }

    // MARK: - 場景初始化
    private func setupScene(content: RealityViewContent) {
        // 可以在這裡添加環境光源等
    }

    // MARK: - 場景更新
    private func updateScene(content: RealityViewContent) {
        // 清空舊實體
        content.entities.removeAll()

        // 渲染玩家太空船
        renderPlayerShip(content: content)

        // 渲染敵人
        renderEnemies(content: content)

        // 渲染子彈
        renderBullets(content: content)

        // 渲染掉落物
        renderDrops(content: content)
    }

    // MARK: - 渲染玩家
    private func renderPlayerShip(content: RealityViewContent) {
        let entity = EntityFactory.createPlayerShip()
        entity.position = gameState.playerShip.position
        content.add(entity)
    }

    // MARK: - 渲染敵人
    private func renderEnemies(content: RealityViewContent) {
        for enemy in gameState.enemies {
            let entity: ModelEntity

            if enemy is EnemyLarge {
                entity = EntityFactory.createLargeEnemy()
            } else {
                entity = EntityFactory.createSmallEnemy()
            }

            entity.position = enemy.position
            content.add(entity)
        }
    }

    // MARK: - 渲染子彈
    private func renderBullets(content: RealityViewContent) {
        for bullet in gameState.bullets {
            let entity = EntityFactory.createBullet(radius: bullet.radius)
            entity.position = bullet.position
            content.add(entity)
        }
    }

    // MARK: - 渲染掉落物
    private func renderDrops(content: RealityViewContent) {
        // XP orbs
        for orb in gameState.xpOrbs {
            let entity = EntityFactory.createXPOrb()
            entity.position = orb.position
            content.add(entity)
        }

        // 零件
        for part in gameState.shipParts {
            let entity = EntityFactory.createShipPart()
            entity.position = part.position
            content.add(entity)
        }
    }
}

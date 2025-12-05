//
//  PickupSystem.swift
//  SpaceWar
//
//  掉落物吸收系統（只吸 XP 和零件，不吸敵人）
//

import Foundation

class PickupSystem {

    private let gameState: GameState

    init(gameState: GameState) {
        self.gameState = gameState
    }

    // MARK: - 更新
    func update(deltaTime: TimeInterval) {
        updateXPOrbs(deltaTime: deltaTime)
        updateShipParts(deltaTime: deltaTime)
    }

    // MARK: - 更新 XP orbs
    private func updateXPOrbs(deltaTime: TimeInterval) {
        let playerPos = gameState.playerShip.position
        let pickupRange = gameState.playerShip.pickupRange

        var orbsToRemove: [Int] = []

        for (index, orb) in gameState.xpOrbs.enumerated() {
            let dist = distance(orb.position, playerPos)

            // 檢查是否進入吸收範圍
            if dist <= pickupRange && !orb.isAttracted {
                orb.isAttracted = true
            }

            // 被吸引的 orb 移動向玩家
            if orb.isAttracted {
                orb.moveTowardsPlayer(playerPosition: playerPos, deltaTime: deltaTime)

                // 檢查是否抵達玩家
                if orb.hasReachedPlayer(playerPosition: playerPos) {
                    gameState.gainXP(amount: orb.xpAmount)
                    orbsToRemove.append(index)
                }
            }
        }

        // 移除已吸收的 orbs
        for index in orbsToRemove.reversed() {
            gameState.xpOrbs.remove(at: index)
        }
    }

    // MARK: - 更新零件
    private func updateShipParts(deltaTime: TimeInterval) {
        let playerPos = gameState.playerShip.position
        let pickupRange = gameState.playerShip.pickupRange

        var partsToRemove: [Int] = []

        for (index, part) in gameState.shipParts.enumerated() {
            let dist = distance(part.position, playerPos)

            // 檢查是否進入吸收範圍
            if dist <= pickupRange && !part.isAttracted {
                part.isAttracted = true
            }

            // 被吸引的零件移動向玩家
            if part.isAttracted {
                part.moveTowardsPlayer(playerPosition: playerPos, deltaTime: deltaTime)

                // 檢查是否抵達玩家
                if part.hasReachedPlayer(playerPosition: playerPos) {
                    gameState.playerShip.gainShipParts(count: part.partCount)
                    partsToRemove.append(index)
                }
            }
        }

        // 移除已吸收的零件
        for index in partsToRemove.reversed() {
            gameState.shipParts.remove(at: index)
        }
    }
}

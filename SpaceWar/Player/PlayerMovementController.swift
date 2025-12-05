//
//  PlayerMovementController.swift
//  SpaceWar
//
//  玩家太空船移動控制（右手捏合拖曳）
//

import Foundation
import ARKit
import RealityKit

@Observable
class PlayerMovementController {

    private var handStartPosition: SIMD3<Float>?
    private var isPinching: Bool = false

    // MARK: - 更新手勢輸入
    func update(handTracking: HandTrackingProvider?, playerShip: PlayerShip, deltaTime: TimeInterval) {
        guard let handTracking = handTracking else { return }

        // 偵測右手捏合
        let rightHand = detectRightHandPinch(handTracking: handTracking)

        if let handPosition = rightHand {
            if !isPinching {
                // 捏合開始
                isPinching = true
                handStartPosition = handPosition
            } else {
                // 捏合持續中
                if let startPos = handStartPosition {
                    let dragVector = handPosition - startPos
                    let dragDistance = length(dragVector)

                    // 超過 dead zone 才移動
                    if dragDistance > GameConfig.handDragDeadZone {
                        let moveDirection = normalize(dragVector)

                        // 計算速度（可以與拖曳距離成比例）
                        var speed = dragDistance * GameConfig.handDragSpeedMultiplier
                        speed = min(speed, GameConfig.maxMoveSpeedFromDrag)

                        // 套用玩家移動速度倍率
                        speed *= playerShip.moveSpeed

                        // 移動太空船
                        playerShip.move(direction: moveDirection, speed: speed, deltaTime: deltaTime)
                    }
                }
            }
        } else {
            // 捏合結束
            isPinching = false
            handStartPosition = nil
        }
    }

    // MARK: - 偵測右手捏合
    private func detectRightHandPinch(handTracking: HandTrackingProvider) -> SIMD3<Float>? {
        // 實際實作需要使用 ARKit HandTracking API
        // 這裡先返回 nil 作為 placeholder
        // 真實實作需要：
        // 1. 取得右手的 HandAnchor
        // 2. 檢查食指與拇指的距離
        // 3. 若距離小於閾值，視為捏合
        // 4. 返回手的 3D 位置

        return nil  // Placeholder
    }
}

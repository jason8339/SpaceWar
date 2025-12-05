//
//  LevelUpSelectionView.swift
//  SpaceWar
//
//  升級選擇畫面
//

import SwiftUI

struct LevelUpSelectionView: View {

    @Environment(GameState.self) private var gameState

    var body: some View {
        VStack(spacing: 20) {
            Text("Level Up!")
                .font(.largeTitle)
                .bold()

            Text("Choose an upgrade:")
                .font(.headline)

            // 這裡應該隨機提供 3-4 個選項（武器或被動）
            // 為了簡化，先顯示示意文字

            Button("New Weapon: Space Cannon") {
                let weapon = PlayerWeapon_SpaceCannon()
                gameState.playerShip.addWeapon(weapon)
                gameState.finishLevelUpSelection()
            }
            .buttonStyle(.bordered)

            Button("Upgrade: Bullet Speed") {
                let passive = Passive_BulletSpeed()
                gameState.playerShip.addPassive(passive)
                gameState.finishLevelUpSelection()
            }
            .buttonStyle(.bordered)

            Button("Upgrade: Max HP") {
                let passive = Passive_MaxHPUp()
                gameState.playerShip.addPassive(passive)
                gameState.finishLevelUpSelection()
            }
            .buttonStyle(.bordered)
        }
        .padding(40)
        .background(.regularMaterial)
        .cornerRadius(20)
    }
}

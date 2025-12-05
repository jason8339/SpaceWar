//
//  GameConfig.swift
//  SpaceWar
//
//  集中管理所有遊戲參數
//

import Foundation

struct GameConfig {

    // MARK: - 玩家基礎參數
    static let playerBaseMaxHP: Double = 100.0
    static let playerBaseMoveSpeed: Float = 2.0  // 公尺/秒
    static let playerBaseBulletDamage: Double = 10.0
    static let playerBasePickupRange: Float = 2.0  // 公尺
    static let playerCollisionRadius: Float = 0.2  // 玩家太空船碰撞半徑

    // MARK: - 武器參數

    // 太空炮 (Space Cannon)
    static let spaceCannonBaseDamage: Double = 15.0
    static let spaceCannonBaseFireRate: Double = 2.0  // 每秒發射次數
    static let spaceCannonBulletSpeed: Float = 5.0
    static let spaceCannonBasePenetration: Int = 1

    // 電磁牆 (Electromagnetic Wall)
    static let electroFieldBaseDPS: Double = 20.0
    static let electroFieldBaseRadius: Float = 1.5

    // 雙軌雷射 (Dual Rail Laser)
    static let laserBeamBaseDPS: Double = 50.0
    static let laserBeamCooldown: Double = 3.0
    static let laserBeamDuration: Double = 0.5
    static let laserBeamBasePenetration: Int = 5
    static let laserBeamSeparation: Float = 0.3  // 兩條雷射間距

    // 反應彈匣 (Reactor Missile Pod)
    static let missilePodBaseDamage: Double = 40.0
    static let missilePodCooldown: Double = 2.5
    static let missilePodMissileCount: Int = 3
    static let missilePodMissileSpeed: Float = 4.0
    static let missilePodExplosionRadius: Float = 1.0

    // 光子刀環 (Photon Blade Ring)
    static let photonRingBaseDPS: Double = 25.0
    static let photonRingBladeCount: Int = 4
    static let photonRingRadius: Float = 1.2
    static let photonRingRotationSpeed: Float = 2.0  // 弧度/秒

    // 脈衝震波 (Pulse Shockwave)
    static let pulseShockwaveBaseDamage: Double = 80.0
    static let pulseShockwaveCooldown: Double = 8.0
    static let pulseShockwaveRadius: Float = 3.0
    static let pulseShockwaveKnockbackForce: Float = 5.0

    // MARK: - 子彈通用參數
    static let bulletBaseRadius: Float = 0.1
    static let bulletMaxLifeTime: Double = 5.0
    static let bulletMaxDistance: Float = 50.0

    // MARK: - 敵人基礎參數

    // 小太空船
    static let enemySmallBaseHP: Double = 30.0
    static let enemySmallBaseMoveSpeed: Float = 1.5
    static let enemySmallBaseContactDamage: Double = 10.0
    static let enemySmallBaseXP: Double = 5.0
    static let enemySmallDropPartChance: Double = 0.3  // 30% 機率掉零件
    static let enemySmallCollisionRadius: Float = 0.15

    // 大太空船
    static let enemyLargeBaseHP: Double = 500.0
    static let enemyLargeBaseMoveSpeed: Float = 0.8
    static let enemyLargeBaseContactDamage: Double = 30.0
    static let enemyLargeBaseXP: Double = 100.0
    static let enemyLargeDropPartMin: Int = 3
    static let enemyLargeDropPartMax: Int = 5
    static let enemyLargeCollisionRadius: Float = 0.4

    // MARK: - 生成參數
    static let smallEnemySpawnPerSecond: Double = 5.0
    static let largeEnemySpawnIntervalSeconds: Double = 60.0
    static let largeEnemyMinIntervalSeconds: Double = 20.0

    // 生成距離
    static let enemySpawnMinDistanceFromPlayer: Float = 3.0
    static let enemySpawnRadiusMin: Float = 5.0
    static let enemySpawnRadiusMax: Float = 8.0

    // MARK: - 難度倍率因子
    static let enemyHPScalePerSecond: Double = 1.0 / 300.0  // 每 5 分鐘翻倍
    static let enemySpeedScalePerSecond: Double = 1.0 / 600.0  // 每 10 分鐘翻倍
    static let xpScalePerSecond: Double = 1.0 / 900.0  // 每 15 分鐘翻倍
    static let dropScalePerSecond: Double = 1.0 / 1200.0  // 每 20 分鐘翻倍

    // MARK: - 經驗值與升級
    static let baseXPToLevelUp: Double = 100.0
    static let xpScalingFactor: Double = 1.5  // 每級所需 XP 增長倍率

    // MARK: - 遊戲目標
    static let victoryTimeSeconds: Double = 30.0 * 60.0  // 30 分鐘

    // MARK: - XP 與零件掉落
    static let xpOrbMagnetSpeed: Float = 5.0  // 被吸引時的移動速度
    static let shipPartMagnetSpeed: Float = 5.0

    // MARK: - 手勢控制參數
    static let handDragDeadZone: Float = 0.02  // 公尺，小於此值不觸發移動
    static let handDragSpeedMultiplier: Float = 3.0  // 拖曳距離轉換成速度的倍率
    static let maxMoveSpeedFromDrag: Float = 5.0  // 從手勢獲得的最大移動速度
}

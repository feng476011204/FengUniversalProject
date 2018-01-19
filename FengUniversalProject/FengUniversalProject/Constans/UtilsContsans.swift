//
//  UtilsContsans.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/19.
//  Copyright © 2018年 feng. All rights reserved.
//

import UIKit


/// 根控制器
let kRootViewController = UIApplication.shared.delegate?.window!!.rootViewController

/// 状态栏高度
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

/// 导航栏高度
let kNavBarHeight = CGFloat(44.0)

/// 底部TabBar的高度
let kTabBarHeight = (UIApplication.shared.statusBarFrame.size.height > 20) ? CGFloat(83.0) : CGFloat(49.0)

/// 顶部的高度
let kTopHeight = kStatusBarHeight + kNavBarHeight

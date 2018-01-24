//
//  UtilsContsans.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/19.
//  Copyright © 2018年 feng. All rights reserved.
//

import UIKit


/// 根控制器
let KRootViewController = UIApplication.shared.delegate?.window!!.rootViewController

/// 状态栏高度
let KStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

/// 导航栏高度
let KNavBarHeight = CGFloat(44.0)

/// 底部TabBar的高度
let KTabBarHeight = (UIApplication.shared.statusBarFrame.size.height > 20) ? CGFloat(83.0) : CGFloat(49.0)

/// 顶部的高度
let KTopHeight = KStatusBarHeight + KNavBarHeight

let KScreenWidth = UIScreen.main.bounds.size.width

let KScreenHeight = UIScreen.main.bounds.size.height

let kScreen_Bounds = UIScreen.main.bounds

let Iphone6ScaleWidth = KScreenWidth / 375.0

let Iphone6ScaleHeight = KScreenHeight / 667.0

let KCurrentSystemVersion = Double(UIDevice.current.systemVersion)

let KVersionName = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

//MARK: -- 本地存储的key

let KVersionNameKey = "KVersionNameKey"

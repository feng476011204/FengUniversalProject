//
//  AppDelegateAppService.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/19.
//  Copyright © 2018年 feng. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    /// 初始化窗口
    public func initWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = kWindowBackGroundColor
        setupRootVc()
        self.window?.makeKeyAndVisible()
        //避免在一个界面上同时点击多个UIButton导致同时响应多个方法
        UIButton.appearance().isExclusiveTouch = true
    }
    
    /// 设置根控制器
    func setupRootVc() {
        if isNeedGuideVc() {
            print("需要引导页")
            UIApplication.shared.keyWindow?.rootViewController = UIViewController()
        }else {
            print("不需要引导页")
            UIApplication.shared.keyWindow?.rootViewController = UIViewController()
        }
    }
    
    /// 判断是否需要引导页面
    ///
    /// - Returns: true:需要 false:不需要
    func isNeedGuideVc() -> Bool {
        let oldVersionName = UserDefaults.standard.value(forKey: KVersionNameKey)
        if let validOldVersionName = oldVersionName as? String {
            if validOldVersionName.elementsEqual(KVersionName) {
                return false
            }
        }
        UserDefaults.standard.set(KVersionName, forKey: KVersionNameKey)
        return true
    }
    /// 初始化第三方服务
    public func initThirdService() {
        
    }
    
    /// 初始化服务
    public func initService() {
        
    }
    
}

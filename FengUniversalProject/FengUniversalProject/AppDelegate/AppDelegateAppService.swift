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
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        self.window?.rootViewController = vc;
        self.window?.makeKeyAndVisible()
        //避免在一个界面上同时点击多个UIButton导致同时响应多个方法
        UIButton.appearance().isExclusiveTouch = true
    }
    
    /// 初始化第三方服务
    public func initThirdService() {
        
    }
    
    /// 初始化服务
    public func initService() {
        
    }
    
}

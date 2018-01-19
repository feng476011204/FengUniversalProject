//
//  AdPageView.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/19.
//  Copyright © 2018年 feng. All rights reserved.
//

import UIKit

class AdPageView: UIView {

    var adView: UIImageView?
    
    var skipButton: UIButton?
    
    var adViewTapClosure: () -> Void?
    
    var showtime: NSInteger
    
    let adImageName = "adImageName"
    
    var countTimer: Timer?
    
    init(frame: CGRect, tapClosure: @escaping () -> Void) {
        adView = UIImageView(frame: frame)
        adViewTapClosure = tapClosure
        showtime = 3
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor.gray
        
        adView?.isUserInteractionEnabled = true
        adView?.contentMode = .scaleAspectFill
        adView?.clipsToBounds = true
        let tapGestRec = UITapGestureRecognizer.init(target: self, action: #selector(adViewTap))
        adView?.addGestureRecognizer(tapGestRec)
        
        let btnW = CGFloat(60.0);
        let btnH = CGFloat(30.0);
        skipButton = UIButton(frame: CGRect(x: KScreenWidth - btnW - 24, y: KTopHeight, width: btnW, height: btnH))
        skipButton?.setTitle("跳过\(showtime)s", for: .normal)
        skipButton?.addTarget(self, action: #selector(skipButtonClick), for: .touchUpInside)
        skipButton?.setTitleColor(UIColor.white, for: .normal)
        skipButton?.backgroundColor = UIColor.darkGray
        skipButton?.layer.cornerRadius = 4;
        
        addSubview(adView!)
        addSubview(skipButton!)
        show()
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        let filePath = UserDefaults.standard.string(forKey: adImageName)?.getFilePathWithImageName()
        let isExisr = filePath?.isFileExistWithFilePath() ?? false
        if isExisr {
            if let newFilePath = filePath {
                setFilePath(filePath: newFilePath)
                show()
            }
        }
    }
    
    func setFilePath(filePath: String) {
        adView?.image = UIImage.init(contentsOfFile: filePath)
    }
    
    func show() {
        startTimer()
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
    }
    
    func startTimer() {
        countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(skipTimeChange), userInfo: nil, repeats: true)
        if let timer = countTimer {
            RunLoop.main.add(timer, forMode: .commonModes)
        }
    }
    
    @objc private func skipTimeChange() {
        showtime = showtime - 1
        skipButton?.setTitle("跳过\(showtime)s", for: .normal)
        if showtime == 0 {
            dismissView()
        }
    }
    
    func dismissView() {
        removeFromSuperview()
        UIApplication.shared.keyWindow?.rootViewController = UIViewController()
    }
    
    @objc private func skipButtonClick(sender: UIButton) {
        
    }
    
    @objc private func adViewTap(tapGestRec: UITapGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

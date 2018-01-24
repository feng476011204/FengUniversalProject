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
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        let filePath = UserDefaults.standard.string(forKey: adImageName)?.getFilePathWithImageName()
        let isExisr = filePath?.isFileExistWithFilePath() ?? false
        if isExisr {
            if let newFilePath = filePath {
                setFilePath(filePath: newFilePath)
                show()
            }
        }
        
        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        getAdvertisingImage()
    }
    
    func getAdvertisingImage() {
        
        let imageArr = ["http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg",
                        "http://pic.paopaoche.net/up/2012-2/20122220201612322865.png",
                        "http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg",
                        "http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"]
        let imageUrl = imageArr[Int(arc4random()) % imageArr.count]
        let stringArr = imageUrl.components(separatedBy: "/")
        let imageName = stringArr.last
        let filePath = imageName?.getFilePathWithImageName()
        let isExisr = filePath?.isFileExistWithFilePath() ?? false
        if !isExisr {
            if let _ = filePath {
                downloadAdImageWithUrl(imageUrl: imageUrl, imageName: imageName)
            }
        }
    }
    
    func downloadAdImageWithUrl(imageUrl: String?, imageName: String?) {
        guard let newImageUrl = imageUrl else {
            return;
        }
        guard let newImageName = imageName else {
            return;
        }
        DispatchQueue.global().async {
            let data = NSData(contentsOf: URL(string: newImageUrl)!)
            guard let newData = data else {
                return;
            }
            let image = UIImage(data: newData as Data)
            let filePath = newImageName.getFilePathWithImageName()
            if let newImage = image {
                do {
                   try UIImagePNGRepresentation(newImage)?.write(to: URL(fileURLWithPath: filePath))
                }
                catch {
                    return;
                }
            }
            self.deleteOldImage()
            UserDefaults.standard.set(newImageName, forKey: self.adImageName)
            UserDefaults.standard.synchronize()
        }
    }
    
    func deleteOldImage() {
        let imageName = UserDefaults.standard.string(forKey: adImageName)
        if let availImageName = imageName  {
            let filePath = availImageName.getFilePathWithImageName()
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(at: URL(fileURLWithPath: filePath))
                print("删除成功啦")
            }
            catch {
                print("删除失败了")
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
        countTimer?.invalidate()
        countTimer = nil
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0;
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc private func skipButtonClick(sender: UIButton) {
        
    }
    
    @objc private func adViewTap(tapGestRec: UITapGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

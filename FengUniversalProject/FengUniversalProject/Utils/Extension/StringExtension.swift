//
//  StringExtension.swift
//  FengUniversalProject
//
//  Created by feng on 2018/1/19.
//  Copyright © 2018年 feng. All rights reserved.
//

import Foundation

extension String {
    
    func getFilePathWithImageName() -> String {
        if self.count > 0 {
            let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
            if let newPath = path {
                return "\(newPath)+\(self)"
            }else {
                return ""
            }
        }
        return ""
    }
    
    func isFileExistWithFilePath() -> Bool {
        let fileManager = FileManager.default
        var isDirectory = ObjCBool(false);
        return fileManager.fileExists(atPath: self, isDirectory: &isDirectory)
    }
}

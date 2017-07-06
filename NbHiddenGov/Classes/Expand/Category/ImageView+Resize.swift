//
//  ImageView+Resize.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/4/1.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.mainScreen().scale);
        self.drawInRect(CGRectMake(0, 0, reSize.width, reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
    
    /**
     * 压缩图片内容，不影响图片的size，得到一个原大小，但更模糊的图片。
     */
    func compressImage(compressionQuality: CGFloat) -> UIImage {
        let reSize = CGSizeMake(400, 300)
        let nsdata = UIImageJPEGRepresentation(reSizeImage(reSize), 0.1)!
        return UIImage(data: nsdata)!
    }
}

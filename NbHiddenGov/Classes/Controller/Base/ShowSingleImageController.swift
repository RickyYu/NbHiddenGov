//
//  ShowSingleImageController.swift
//  ZhiAnTongCpy
//
//  Created by Ricky on 2017/4/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class ShowSingleImageController: BaseViewController {
    
    var imageView :UIImageView! = nil
    var image :UIImage!
    
    override func viewDidLoad() {
        setNavagation("图片详情")
        imageView = getImageView()
        imageView.image = image
    }
    
    func getImageView()->UIImageView{
        let imageView = UIImageView(frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        self.view.addSubview(imageView)
       return imageView
    }
}

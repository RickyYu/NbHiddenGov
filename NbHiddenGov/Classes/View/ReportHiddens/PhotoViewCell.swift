//
//  PhotoViewCell.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/26.
//  Copyright © 2017年 safetys. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var  model: Cell?
        {
        didSet{
            if let art = model {
                // 设置数据
                self.imgView.image = UIImage(named: art.image)
                self.labelName.text = art.title
//                self.contentName.text = art.value
            }
        }
    }
    

    
}

//
//  ShopInfoCell.swift
//  Mineral
//
//  Created by Ricky on 2017/3/29.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class CompanyInfoCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var labelName: UILabel!
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
                self.contentName.text = art.value
            }
        }
    }
    
}


//
//  SaleRecordsCell.swift
//  Mineral
//
//  Created by Ricky on 2017/3/17.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class SaleRecordsCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var rightTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var  model: CompanyInfoModel?
        {
        didSet{
            if let art = model {
                // 设置数据
                self.name?.text = art.companyName
                self.des?.text = "联系电话：\(art.safetyMngPersonPhone)"
                self.content.text = "联系人：\(art.safetyMngPerson)"

            }
        }
    }
    
    var  dangerModel: DangerModel?
        {
        didSet{
            if let art = dangerModel {
                // 设置数据
                self.name?.text = art.descriptions
                self.content?.text = art.hazardSourceName
                var repairStr = ""
                if art.repaired as Bool {
                 repairStr = "已整改"
                }else{
                repairStr = "未整改"
                }
                self.des.text = repairStr
                self.rightTime.text = art.createTime
                
            }
        }
    }
}

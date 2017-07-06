//
//  ChildDaIndustryModel.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/25.
//  Copyright © 2017年 safetys. All rights reserved.
//

class ChildDaIndustryModel:BaseModel{

    var code: String?
    var id: NSNumber?
    var fatherId: NSNumber?
    var name: String?

    
    init(dict: [String: AnyObject]) {
        super.init()
        self.code = dict["code"] as? String
        self.id = dict["id"] as?  NSNumber
        self.fatherId = dict["fatherId"] as? NSNumber
        self.name = dict["name"] as? String ?? ""
        
}
}

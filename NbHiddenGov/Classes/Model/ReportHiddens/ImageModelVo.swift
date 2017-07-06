//
//  ImageModelVo.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/26.
//  Copyright © 2017年 safetys. All rights reserved.
//

class ImageModelVo:BaseModel{
    var id:Int!
    var name:String!
    var path:String!
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        self.id = dict["id"] as? Int
        self.name = dict["name"] as? String ?? ""
        self.path = dict["path"] as? String ?? ""
    }
}

//
//  DangerModel.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//

class DangerModel:BaseModel{
    var descriptions:String!
    var id:Int!
    var linkTel:String!
    var hazardSourceCode:String!
    var industryText:String!
    var completedDate:String!
    var imageList:String!
    var allowEdit:Bool!
    var createTime:String!
    var governMoney:Int!
    var hazardSourceName:String!
    var companyName:String!
    var industryId:Int!
    var linkMan:String!
    var repaired:Bool!
    var secondIndustryId:Int!
    var secondIndustryText:String!
    var userId:Int!
    
    var zgStateStr:String!
    var yhTypeName:String!
    
    init(createTime:String) {
        super.init()
        self.descriptions =  ""
        self.id = -1
        self.linkTel = ""
        self.hazardSourceCode =  "NP_1"
        self.industryText = ""
        self.completedDate = ""
        self.imageList =  ""
        self.allowEdit = false
        self.createTime = createTime
        self.governMoney = nil
        self.hazardSourceName =  "企业自查"
        self.companyName = ""
        self.industryId = nil
        self.linkMan = ""
        self.repaired = false
        self.secondIndustryId = nil
        self.secondIndustryText =  ""
        self.userId = nil
        self.zgStateStr = "未整改"
        self.yhTypeName = ""
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.descriptions = dict["description"] as? String ?? ""
        self.id = dict["id"] as? Int
        self.linkTel = dict["linkTel"] as? String ?? ""
        self.hazardSourceCode = dict["hazardSourceCode"] as? String ?? ""
        self.industryText = dict["industryText"] as? String ?? ""
        self.completedDate = dict["completedDate"] as? String ?? ""
        self.imageList = dict["imageList"] as? String ?? ""
        self.allowEdit = dict["allowEdit"] as? Bool
        self.createTime = dict["createTime"] as? String ?? ""
        self.governMoney = dict["governMoney"] as? Int
        self.hazardSourceName = dict["hazardSourceName"] as? String ?? ""
        self.companyName = dict["companyName"] as? String ?? ""
        self.industryId = dict["industryId"] as? Int
        self.linkMan = dict["linkMan"] as? String ?? ""
        self.repaired = dict["repaired"] as? Bool
        self.secondIndustryId = dict["secondIndustryId"] as? Int
        self.secondIndustryText = dict["secondIndustryText"] as? String ?? ""
        self.userId = dict["userId"] as? Int
        if self.repaired!{
            self.zgStateStr = "已整改"
        }else {
            self.zgStateStr = "未整改"
        }
        
        
        self.yhTypeName = ""
    }

    
    func getCells() -> Dictionary<Int, [Cell]>{
        return [
            0:[
                Cell(fieldName: "hazardSourceName", image: "point", title: "录入隐患来源", value: self.hazardSourceName, state: .ENUM,maxLength: 20)
            ],
            1:[
                Cell(fieldName: "descriptions", image: "point", title: "隐患描述", value: self.descriptions, state: .MULTI_TEXT,maxLength: 20),
                Cell(fieldName: "secondIndustryText", image: "point", title: "隐患类别", value: self.yhTypeName, state: .ENUM,maxLength: 20)
            ],
            2:[
                Cell(fieldName: "companyName", image: "point", title: "公司名称", value: self.companyName, state: .SKIP,maxLength: 20),
                Cell(fieldName: "linkMan", image: "point", title: "隐患填报人", value: self.linkMan, state: .TEXT,maxLength: 20),
                Cell(fieldName: "linkTel", image: "point", title: "联系电话", value: self.linkTel, state: .TEXT,maxLength: 20),
                Cell(fieldName: "repaired", image: "point", title: "整改状态", value: self.zgStateStr, state: .ENUM,maxLength: 20),
                Cell(fieldName: "createTime", image: "point", title: "录入时间", value: self.createTime, state: .READ,maxLength: 20),
                Cell(fieldName: "completedDate", image: "point", title: "整改时间", value: self.completedDate, state: .TIME,maxLength: 20),
                Cell(fieldName: "imageList", image: "point", title: "隐患的照片", value: self.imageList, state: .IMAGE,maxLength: 20)
            ]
        ]
    }
    
    
    
}

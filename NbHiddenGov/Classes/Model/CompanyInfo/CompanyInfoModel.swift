//
//  CompanyInfoModel.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//

import SwiftyJSON

class CompanyInfoModel:BaseModel{
    var safetyMngPersonPhone:String!
    var economicType2:String!
    var safetyMngPerson:String!
    var businessScope:String!
    var naEcoType1:String!
    var naEcoType2:String!
    var economicType1:String!
    var thirdArea:String!
    var regAddress:String!
    var secondArea:String!
    var productionScale:String!
    var secondAreaName:String!
    var thirdAreaName:String!
    var id:Int!
    var firstAreaName:String!
    var fouthAreaName:String!
    var tradeTypeText:String!
    var firstArea:String!
    var companyName:String!
    var fouthArea:String!
    var setupNumber:String!
    var fddelegate:String!
    var regNum:String!
    var address:String!
    
    var jjlxName:String!
    var gmjjlxName:String!
    var qygmName:String!
    
    override init() {
        super.init()
    }
    
    init(datas: JSON){
        super.init()
        self.initBaseCompanyData(datas["company"].dictionaryObject!)
        //存储CompanyScaleModel
        if let items = datas["companyScaleEnums"].arrayObject {
            var models = [CompanyScaleModel]()
            for item in items {
                let homeItem = CompanyScaleModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            CompanyScaleModel.savaModels(models)
        }
        
        //存储ChildNationalEconomicModel
        if let items = datas["companyScaleEnums"].arrayObject {
            var models = [ChildNationalEconomicModel]()
            for item in items {
                let homeItem = ChildNationalEconomicModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            ChildNationalEconomicModel.savaModels(models)
            
        }
        
        //存储ChildNationalEconomicModel
        if let items = datas["companyScaleEnums"].arrayObject {
            var models = [ChildNationalEconomicModel]()
            for item in items {
                let homeItem = ChildNationalEconomicModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            ChildNationalEconomicModel.savaModels(models)
            
        }
        
        
        //存储NationalEconomicModel
        if let items = datas["nationalEconomicEnums"].arrayObject {
            var models = [NationalEconomicModel]()
            for item in items {
                let homeItem = NationalEconomicModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            NationalEconomicModel.savaModels(models)
            
        }
        
        //存储ChildEconomyKindModel
        if let items = datas["childEconomyKindEnums"].arrayObject {
            var models = [ChildEconomyKindModel]()
            for item in items {
                let homeItem = ChildEconomyKindModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            ChildEconomyKindModel.savaModels(models)
            
        }
        
        //存储EconomyKindModel
        if let items = datas["economyKindEnums"].arrayObject {
            var models = [EconomyKindModel]()
            for item in items {
                let homeItem = EconomyKindModel(dict: item as! [String: AnyObject])
                models.append(homeItem)
            }
            //保存在本地
            EconomyKindModel.savaModels(models)
            
        }
        
    }
    
    init(firstArea:Int) {
        self.safetyMngPersonPhone = ""
        self.economicType2 = ""
        self.safetyMngPerson =  ""
        self.businessScope =  ""
        self.naEcoType1 =  ""
        self.naEcoType2 = ""
        self.economicType1 =  ""
        self.thirdArea = ""
        self.regAddress = ""
        self.secondArea =  ""
        self.productionScale = ""
        self.id = -1
        self.secondAreaName = ""
        self.thirdAreaName = ""
        self.firstAreaName = ""
        self.fouthAreaName = ""
        self.tradeTypeText =  ""
        self.firstArea = ""
        self.companyName = ""
        self.fouthArea = ""
        self.setupNumber = ""
        self.fddelegate = ""
        self.regNum = ""
        self.address = ""
        self.jjlxName = ""
        self.gmjjlxName = ""
        self.qygmName = ""
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.safetyMngPersonPhone = dict["safetyMngPersonPhone"] as? String ?? ""
        self.economicType2 = dict["economicType2"] as? String ?? ""
        self.safetyMngPerson = dict["safetyMngPerson"] as? String ?? ""
        self.businessScope = dict["businessScope"] as? String ?? ""
        self.naEcoType1 = dict["naEcoType1"] as? String ?? ""
        self.naEcoType2 = dict["naEcoType2"] as? String ?? ""
        self.economicType1 = dict["economicType1"] as? String ?? ""
        self.thirdArea = dict["thirdArea"] as? String ?? ""
        self.regAddress = dict["regAddress"] as? String ?? ""
        self.secondArea = dict["secondArea"] as? String ?? ""
        self.productionScale = dict["productionScale"] as? String ?? ""
        self.id = dict["id"] as? Int
        self.secondAreaName = dict["secondAreaName"] as? String ?? ""
        self.thirdAreaName = dict["thirdAreaName"] as? String ?? ""
        self.firstAreaName = dict["firstAreaName"] as? String ?? ""
        self.fouthAreaName = dict["fouthAreaName"] as? String ?? ""
        self.tradeTypeText = dict["tradeTypeText"] as? String ?? ""
        self.firstArea = dict["firstArea"] as? String ?? ""
        self.companyName = dict["companyName"] as? String ?? ""
        self.fouthArea = dict["fouthArea"] as? String ?? ""
        self.setupNumber = dict["setupNumber"] as? String ?? ""
        self.fddelegate = dict["fddelegate"] as? String ?? ""
        self.regNum = dict["regNum"] as? String ?? ""
        self.address = dict["address"] as? String ?? ""
        self.jjlxName = ""
        self.gmjjlxName = ""
        self.qygmName = ""
    }
    
    func initBaseCompanyData(dict: [String: AnyObject]){
        self.safetyMngPersonPhone = dict["safetyMngPersonPhone"] as? String ?? ""
        self.economicType2 = dict["economicType2"] as? String ?? ""
        self.safetyMngPerson = dict["safetyMngPerson"] as? String ?? ""
        self.businessScope = dict["businessScope"] as? String ?? ""
        self.naEcoType1 = dict["naEcoType1"] as? String ?? ""
        self.naEcoType2 = dict["naEcoType2"] as? String ?? ""
        self.economicType1 = dict["economicType1"] as? String ?? ""
        self.thirdArea = dict["thirdArea"] as? String ?? ""
        self.regAddress = dict["regAddress"] as? String ?? ""
        self.secondArea = dict["secondArea"] as? String ?? ""
        self.productionScale = dict["productionScale"] as? String ?? ""
        self.id = dict["id"] as? Int
        self.secondAreaName = dict["secondAreaName"] as? String ?? ""
        self.thirdAreaName = dict["thirdAreaName"] as? String ?? ""
        self.firstAreaName = dict["firstAreaName"] as? String ?? ""
        self.fouthAreaName = dict["fouthAreaName"] as? String ?? ""
        self.tradeTypeText = dict["tradeTypeText"] as? String ?? ""
        self.firstArea = dict["firstArea"] as? String ?? ""
        self.companyName = dict["companyName"] as? String ?? ""
        self.fouthArea = dict["fouthArea"] as? String ?? ""
        self.setupNumber = dict["setupNumber"] as? String ?? ""
        self.fddelegate = dict["fddelegate"] as? String ?? ""
        self.regNum = dict["regNum"] as? String ?? ""
        self.address = dict["address"] as? String ?? ""
        self.jjlxName = ""
        self.gmjjlxName = ""
        self.qygmName = ""
    }
    
    
    
    func getCells() -> Dictionary<Int, [Cell]>{
        return [
            0:[
                Cell(fieldName: "companyName", image: "dwmc", title: "单位名称", value: self.companyName, state: .TEXT,maxLength: 20),
                Cell(fieldName: "regAddress", image: "zcdz", title: "注册地址", value: self.regAddress, state: .READ,maxLength: 20),
                Cell(fieldName: "address", image: "szdz", title: "所在地址", value: self.address, state: .READ,maxLength: 20),
                Cell(fieldName: "companyName", image: "sshy", title: "所属行业", value: self.tradeTypeText, state: .READ,maxLength: 20),
                Cell(fieldName: "regNum", image: "gszch", title: "工商注册号/信用代码", value: self.regNum, state: .READ,maxLength: 20)
            ],
            1:[
                Cell(fieldName: "firstAreaName", image: "szqy", title: "所在区域", value: self.firstAreaName+self.secondAreaName+self.thirdAreaName+self.fouthAreaName, state: .READ,maxLength: 20),
                Cell(fieldName: "naEcoType1", image: "jjlx", title: "经济类型", value: self.jjlxName, state: .READ,maxLength: 18),
                Cell(fieldName: "naEcoType1", image: "gmjjfl", title: "国民经济分类", value: self.gmjjlxName, state: .READ, maxLength: 13)
            ],
            2:[
                   Cell(fieldName: "fddelegate", image: "frdb", title: "法人代表", value: self.fddelegate, state: .READ,maxLength: 20),
                   Cell(fieldName: "safetyMngPerson", image: "agfzr", title: "安管负责人", value: self.safetyMngPerson, state: .READ,maxLength: 20),
                   Cell(fieldName: "safetyMngPersonPhone", image: "phone", title: "安管负责人电话", value: self.safetyMngPersonPhone, state: .READ,maxLength: 20),
                   Cell(fieldName: "firstAreaName", image: "qygm", title: "企业规模", value: self.qygmName, state: .READ,maxLength: 20),
                   Cell(fieldName: "businessScope", image: "jyfw", title: "经营范围", value: self.businessScope, state: .MULTI_TEXT,maxLength: 20),
            
            
            ]
        ]
    }



}
//
//  CompanyInfoModel.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//

import SwiftyJSON

class CompanyInfoModel:BaseModel,NSCoding{
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
    
    // MARK: - 保存和获取所有分类
    static let CompanyInfoModelKey = "CompanyInfoModelKey"
    
    private let  safetyMngPersonPhone_key = "safetyMngPersonPhone"
    private let  economicType2_key = "economicType2"
    private let  safetyMngPerson_key = "safetyMngPerson"
    private let  businessScope_key = "businessScope"
    private let  naEcoType1_key = "naEcoType1"
    private let  naEcoType2_key = "naEcoType2"
    private let  economicType1_key = "economicType1"
    private let  thirdArea_key = "thirdArea"
    private let  regAddress_key = "regAddress"
    private let  secondArea_key = "secondArea"
    private let  productionScale_key = "productionScale"
    private let  secondAreaName_key = "secondAreaName"
    private let  thirdAreaName_key = "thirdAreaName"
    private let  id_key = "id"
    private let  firstAreaName_key = "firstAreaName"
    private let  fouthAreaName_key = "fouthAreaName"
    private let  tradeTypeText_key = "tradeTypeText"
    private let  firstArea_key = "firstArea"
    private let  companyName_key = "companyName"
    private let  fouthArea_key = "fouthArea"
    private let  setupNumber_key = "setupNumber"
    private let  fddelegate_key = "fddelegate"
    private let  regNum_key = "regNum"
    private let  address_key = "address"
    
    //序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(safetyMngPersonPhone, forKey: safetyMngPersonPhone_key)
        aCoder.encodeObject(economicType2, forKey: economicType2_key)
        
        aCoder.encodeObject(safetyMngPerson, forKey: safetyMngPerson_key)
        aCoder.encodeObject(businessScope, forKey: businessScope_key)
        
        aCoder.encodeObject(naEcoType1, forKey: naEcoType1_key)
        aCoder.encodeObject(naEcoType2, forKey: naEcoType2_key)
        aCoder.encodeObject(economicType1, forKey: economicType1_key)
        
        
        aCoder.encodeObject(thirdArea, forKey: thirdArea_key)
        aCoder.encodeObject(regAddress, forKey: regAddress_key)
        
        aCoder.encodeObject(secondArea, forKey: secondArea_key)
        
        aCoder.encodeObject(productionScale, forKey: productionScale_key)
        
        aCoder.encodeObject(secondAreaName, forKey: secondAreaName_key)
        aCoder.encodeObject(thirdAreaName, forKey: thirdAreaName_key)
        
        aCoder.encodeObject(id, forKey: id_key)
        aCoder.encodeObject(firstAreaName, forKey: firstAreaName_key)
        
        aCoder.encodeObject(fouthAreaName, forKey: fouthAreaName_key)
        aCoder.encodeObject(tradeTypeText, forKey: tradeTypeText_key)
        aCoder.encodeObject(firstArea, forKey: firstArea_key)
        
        
         aCoder.encodeObject(companyName, forKey: companyName_key)
         aCoder.encodeObject(setupNumber, forKey: setupNumber_key)
         aCoder.encodeObject(fddelegate, forKey: fddelegate_key)
         aCoder.encodeObject(regNum, forKey: regNum_key)
         aCoder.encodeObject(address, forKey: address_key)
    }
    //反序列化
    required init?(coder aDecoder: NSCoder) {
        
        address = aDecoder.decodeObjectForKey(address_key) as? String
        regNum = aDecoder.decodeObjectForKey(regNum_key) as? String
        fddelegate = aDecoder.decodeObjectForKey(fddelegate_key) as? String
        setupNumber = aDecoder.decodeObjectForKey(setupNumber_key) as? String
        
        
          fouthArea = aDecoder.decodeObjectForKey(fouthArea_key) as? String
         companyName = aDecoder.decodeObjectForKey(companyName_key) as? String
         firstArea = aDecoder.decodeObjectForKey(firstArea_key) as? String
         tradeTypeText = aDecoder.decodeObjectForKey(tradeTypeText_key) as? String
         fouthAreaName = aDecoder.decodeObjectForKey(fouthAreaName_key) as? String
         firstAreaName = aDecoder.decodeObjectForKey(firstAreaName_key) as? String
         id = aDecoder.decodeObjectForKey(id_key) as? Int
         thirdAreaName = aDecoder.decodeObjectForKey(thirdAreaName_key) as? String
         secondAreaName = aDecoder.decodeObjectForKey(secondAreaName_key) as? String
         productionScale = aDecoder.decodeObjectForKey(productionScale_key) as? String
         secondArea = aDecoder.decodeObjectForKey(secondArea_key) as? String
         regAddress = aDecoder.decodeObjectForKey(regAddress_key) as? String
         thirdArea = aDecoder.decodeObjectForKey(thirdArea_key) as? String
        
         economicType1 = aDecoder.decodeObjectForKey(economicType1_key) as? String
         naEcoType2 = aDecoder.decodeObjectForKey(naEcoType2_key) as? String
         naEcoType1 = aDecoder.decodeObjectForKey(naEcoType1_key) as? String
         businessScope = aDecoder.decodeObjectForKey(businessScope_key) as? String
         safetyMngPerson = aDecoder.decodeObjectForKey(safetyMngPerson_key) as? String
         economicType2 = aDecoder.decodeObjectForKey(economicType2_key) as? String
         safetyMngPersonPhone = aDecoder.decodeObjectForKey(safetyMngPersonPhone_key) as? String
    }
    
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaCompanyInfoModels(companyInfoModels: [CompanyInfoModel])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(companyInfoModels)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: CompanyInfoModel.CompanyInfoModelKey)
    }
    
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalCompanyInfoModels() -> [CompanyInfoModel]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(CompanyInfoModel.CompanyInfoModelKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [CompanyInfoModel]
        }
        return nil
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
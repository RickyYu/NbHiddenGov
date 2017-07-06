//
//  CompanyScaleModel.swift
//
//
//  Created by Ricky on 2017/6/24.
//
//

class ChildEconomyKindModel:BaseModel,NSCoding{
    // MARK: - 保存和获取所有分类
    static let ChildEconomyKindModelKey = "ChildEconomyKindModelKey"
    var code: String?
    var id: NSNumber?
    var fatherId: NSNumber?
    var name: String?
    
    // MARK: - 序列化和反序列化
    private let code_Key = "code"
    private let id_Key = "id"
    private let fatherId_Key = "fatherId"
    private let name_Key = "name"
    
    init(dict: [String: AnyObject]) {
        super.init()
        self.code = dict["code"] as? String
        self.id = dict["id"] as?  NSNumber
        self.fatherId = dict["fatherId"] as? NSNumber
        self.name = dict["name"] as? String ?? ""
        
    }
    
    // 序列化
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(code, forKey: code_Key)
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(fatherId, forKey: fatherId_Key)
        aCoder.encodeObject(name, forKey: name_Key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObjectForKey(code_Key) as? String
        id =  aDecoder.decodeObjectForKey(id_Key) as? NSNumber
        fatherId = aDecoder.decodeObjectForKey(fatherId_Key) as? NSNumber
        name =  aDecoder.decodeObjectForKey(name_Key) as? String
    }
    
    
    /**
     保存所有的分类
     
     - parameter categories: 分类数组
     */
    class func savaModels(models: [ChildEconomyKindModel])
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(models)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: ChildEconomyKindModel.ChildEconomyKindModelKey)
    }
    
    /**
     取出本地保存的分类
     
     - returns: 分类数组或者nil
     */
    class func loadLocalModels() -> [ChildEconomyKindModel]?
    {
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(ChildEconomyKindModel.ChildEconomyKindModelKey)
        {
            return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [ChildEconomyKindModel]
        }
        return nil
    }
    
}

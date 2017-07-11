//
//  NetworkTool.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/23.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD


class NetworkTool: Alamofire.Manager {
    // MARK: - 单例
    internal static let sharedTools: NetworkTool = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var header : Dictionary =  Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        return NetworkTool(configuration: configuration)
        
    }()
    
    //获取AppStore版本号
    func getVersion(parameters:[String:AnyObject],finished: (data : String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let path = NSString(format: "http://itunes.apple.com/cn/lookup?id=%@", APPSTOR_ID) as String
        let headers = [
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]

        request(.POST, path, parameters: parameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response.result.value{
                let dict = JSON(dictValue)
                print("getVersion = \(dict)")

//                if let results = dict["results"].arrayObject {
//                 if let dicts = results.firstObject as? NSDictionary {
//                    if let version = dicts["version"] as? String {
//                        finished(data: version,error: nil) //success  false
//                    }
//                }else{
//                    finished(data: nil,error: "") //success  false
//                }
//                }
                finished(data: nil,error: "") //success  false
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: "数据异常")
            }
        }
    }

    
    //MARK: - 登陆
    func login(parameters:[String:AnyObject],finished:(login:Login!,error:String!)->()){
          SVProgressHUD.showWithStatus("正在加载...")
        let identify = ""
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        //"Content-Type": "application/json;charset=UTF-8"  加上此header报type不能为空
        request(.POST, AppTools.getServiceURLWithYh("LOGIN"), parameters: addParameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response.result.value{
                let dict = JSON(dictValue)
                print("login.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let login = Login(json:dict)
                    finished(login: login, error: nil)
                    
                }else{
                    SVProgressHUD.dismiss()
                    finished(login: nil,error: message) //success  false
                }
            }else {
                finished(login: nil,error: NOTICE_NETWORK_FAILED)
            }
            SVProgressHUD.dismiss()
            
        }
    }
    
    
    
    func getCompanyInfo(parameters:[String:AnyObject],finished: (data : CompanyInfoModel!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_COMPANY_INFO"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getCompanyInfo = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let datas = JSON(dict["data"].dictionaryObject!)
                    let data = CompanyInfoModel(datas: datas)
                    finished(data: data, error: nil)
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    func getDangerInfo(parameters:[String:AnyObject],finished: (imageModels:[ImageModelVo]!,childDaIndustryModels : [ChildDaIndustryModel]!,parentDaIndustryModels : [ParentDaIndustryModel]!, error: String!)->()) {
      //  SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_DANGER_INFO"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getCompanyInfo = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let datas = JSON(dict["data"].dictionaryObject!)
                    
                    var childDaIndustryModels = [ChildDaIndustryModel]()
                    if let items = datas["childDaIndustryParameters"].arrayObject {
                        for item in items {
                            let homeItem = ChildDaIndustryModel(dict: item as! [String: AnyObject])
                            childDaIndustryModels.append(homeItem)
                        }
                    }
                    
                    var parentDaIndustryModels = [ParentDaIndustryModel]()
                    if let items = datas["parentDaIndustryParameters"].arrayObject {
                        for item in items {
                            let homeItem = ParentDaIndustryModel(dict: item as! [String: AnyObject])
                            parentDaIndustryModels.append(homeItem)
                        }
                    }
                    var imageModels = [ImageModelVo]()
                   
                    for (key, _) in parameters {
                       if  !AppTools.isEmpty(key){
                            let daNomalDanger  = datas["daNomalDanger"].dictionaryObject!
                            let dJson = JSON(daNomalDanger)
                            
                            if let items = dJson["imageList"].arrayObject {
                                for item in items {
                                    let homeItem = ImageModelVo(dict: item as! [String: AnyObject])
                                    imageModels.append(homeItem)
                                }
                            }
                        }
                    }
    
                    finished(imageModels:imageModels,childDaIndustryModels: childDaIndustryModels,parentDaIndustryModels:parentDaIndustryModels, error: nil)
                    
                }else{
                    finished(imageModels:nil,childDaIndustryModels: nil,parentDaIndustryModels:nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(imageModels:nil,childDaIndustryModels: nil,parentDaIndustryModels:nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    

    
    
    func getRecordInfo(parameters:[String:AnyObject],finished: (data : SaleRecordModel!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_RECORD_INFO"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getRecordInfo = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    
                    let data = SaleRecordModel(dict:dict["entity"].dictionaryObject!)
                    finished(data: data, error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    func updatePassWord(parameters:[String:AnyObject],finished: (data :String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("CHANGE_PASSWORD"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)

                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("updatePassWord = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    finished(data: "success",error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    
    func changePhone(parameters:[String:AnyObject],finished: (data :String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("CHANGE_PHONE"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("CHANGE_PHONE = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    finished(data: "success",error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }

    
    func updateCpyInfo(parameters:[String:AnyObject],finished: (data : String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("UPDATE_CPY_INFO"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("update = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                     finished(data: "success",error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                SVProgressHUD.dismiss()
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    
    
    func deleteDanger(parameters:[String:AnyObject],finished: (data : String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("DELETE_DANGER_INFO"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("deleteSaleRecord = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    finished(data: "success",error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED)
            }
            
        }
    }
    
    func saveInfo(parameters:[String:AnyObject],imageArrays:[UIImage],finished: (data : String!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_NBYHPC="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        
        upload(.POST, AppTools.getServiceURLWithYh("SUBMIT_DANGER_INFO"), headers:headers,multipartFormData: { (multipartFormData) in
            
            print("imageArrays.count = \(imageArrays.count)")
            if !imageArrays.isEmpty{
                for i in 0..<imageArrays.count{
                    let data = UIImageJPEGRepresentation(imageArrays[i] , 0.5)
                    let randomNum :Int = AppTools.createRandomMan(0, end: 100000)()
                    let imageName = String(NSDate()) + "\(randomNum).jpg"
                    print("imageName = \(imageName)")
                    multipartFormData.appendBodyPart(data: data!, name: "upFiles", fileName: imageName, mimeType: "image/jpg")
                }
            }
            
            // 这里就是绑定参数的地方 param 是需要上传的参数，我这里是封装了一个方法从外面传过来的参数，你可以根据自己的需求用NSDictionary封装一个param
            for (key, value) in parameters {
                print("key = \(key)value = \(value)")
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
                
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    if let dictValue = response.result.value{
                        let dict = JSON(dictValue)
                        print("SUBMIT_DANGER_INFO = \(dict)")
                        let success = dict["success"].boolValue
                        let message = dict["msg"].stringValue
                        //  字典转成模型
                        if success {
                         
                            finished(data: "success",error: nil) //success  false
                            
                        }else{
                            finished(data: nil,error: message) //success  false
                        }
                        SVProgressHUD.dismiss()
                        
                    }else {
                        SVProgressHUD.dismiss()
                        finished(data: nil,error: "数据异常")
                    }
                    
                })
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "数据异常")
            }
        }
//
//        
//        self.sendPostRequest(AppTools.getServiceURLWithYh("SUBMIT_DANGER_INFO"), parameters: parameters) { (response) in
//            
//            guard response!.result.isSuccess else {
//                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
//                return
//            }
//            if let dictValue = response!.result.value{
//                let dict = JSON(dictValue)
//                print("saveInfo = \(dict)")
//                let success = dict["success"].boolValue
//                let message = dict["msg"].stringValue
//                //  字典转成模型
//                if success {
//                    finished(data: "success",error: nil) //success  false
//                    
//                }else{
//                    finished(data: nil,error: message) //success  false
//                }
//                SVProgressHUD.dismiss()
//            }else {
//                finished(data: nil,error: "数据异常")
//            }
//            
//        }
    }
    

    
    func getCompanyList(parameters:[String:AnyObject],isShowProgress:Bool,finished: (data : [CompanyInfoModel]!, error: String!,totalCount:Int!)->()) {
        if isShowProgress {
            SVProgressHUD.showWithStatus("正在加载...")
        }
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_COMPANY_LIST"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("GET_COMPANY_LIST = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["data"].arrayObject {
                        var companyInfoModels = [CompanyInfoModel]()
                        for item in items {
                            let homeItem = CompanyInfoModel(dict: item as! [String: AnyObject])
                            companyInfoModels.append(homeItem)
                        }
                        finished(data: companyInfoModels,error: nil,totalCount: totalCount)
                        //  保存在本地 暂无需使用
                        // CpyInfoModel.savaCpyInfoModels(cpyInfoModels)
                        CompanyInfoModel.savaCompanyInfoModels(companyInfoModels)
                    }
                    
                }else{
                    finished(data: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED,totalCount: nil)
            }
            
        }
    }
    
    func getDangerList(parameters:[String:AnyObject],finished: (data : [DangerModel]!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_DANGER_LIST"), parameters: parameters) { (response) in
            print(response!)
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("GET_DANGER_LIST = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["data"].arrayObject {
                        var saleRecordModels = [DangerModel]()
                        for item in items {
                            let homeItem = DangerModel(dict: item as! [String: AnyObject])
                            saleRecordModels.append(homeItem)
                        }
                        finished(data: saleRecordModels,error: nil,totalCount: totalCount)
                        //  保存在本地 暂无需使用
                        // CpyInfoModel.savaCpyInfoModels(cpyInfoModels)
                    }
                    
                }else{
                    finished(data: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: NOTICE_NETWORK_FAILED,totalCount: nil)
            }
            
        }
    }
    
    
    //MARK:获取企业经纬度
    func getPoint(parameters:[String:AnyObject],finished:(locInfoModel:Login!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithDa("GET_POINT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus(NOTICE_NETWORK_FAILED)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getPoint.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                }else{
                    finished(locInfoModel: nil,error: message) //success  false
                }
                 SVProgressHUD.dismiss()
            }else {
                finished(locInfoModel: nil,error: NOTICE_NETWORK_FAILED)
            }
           
            
        }
    }
    

    func sendPostRequest(URL:String,parameters:[String:AnyObject],finished:(response:Response<AnyObject, NSError>!)->()){
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_NBYHPC="+identify
                      let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
            ]
        //"Content-Type": "application/json;charset=UTF-8"  加上此header报type不能为空
          request(.POST, URL, parameters: addParameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
               finished(response: response)
        }

     }
    
    func sendGetRequest(URL:String,parameters:[String:AnyObject],finished:(response:Response<AnyObject, NSError>!)->()){
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SXS_FIREWORK_CLIENT_AUTH_KEY_2017="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        //"Content-Type": "application/json;charset=UTF-8"  加上此header报type不能为空
        request(.GET, URL, parameters: addParameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
            finished(response: response)
        }
        
    }
    
}

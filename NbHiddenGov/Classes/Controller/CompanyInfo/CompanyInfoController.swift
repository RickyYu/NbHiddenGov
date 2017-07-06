//
//  TestShopInfoController.swift
//  Mineral
//
//  Created by Ricky on 2017/3/29.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class CompanyInfoController: BaseViewController, UITableViewDelegate, UITableViewDataSource,NSXMLParserDelegate,ParameterDelegate,MultiParameterDelegate{
    let ReuseIdentifier = "CompanyInfoCell"
    var cells: Dictionary<Int, [Cell]>? = [:]
    var companyInfoModel: CompanyInfoModel! = CompanyInfoModel(firstArea: 1)
    var customTableView:UITableView!
    var parse:NSXMLParser! = nil
    var dictArea:Dictionary<String,String> = ["1":"1"]
    var firstArea :String = "330200000000"
    var secondArea :String = ""
    var thirdArea :String = ""
    var firstAreaName:String!
    var secondAreaName:String!
    var thirdAreaName:String!
    var secondAreaChoiceName:String = ""
    var thirdAreaChoiceName:String = ""
    let indexPaths: [NSIndexPath] = []
    var isSave:Bool = false  //第一次进入该页面才有保存，之后都无法保存
    
    override func viewDidLoad() {
        setNavagation("企业基本信息")
        parse = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("nbyhpc_area", ofType: "xml")!))!
        parse.delegate = self
        parse.parse()
        customTableView = getTableView()
        self.view.addSubview(customTableView)
        self.cells = companyInfoModel.getCells()
        getData()
        self.setData(companyInfoModel)
        self.customTableView.reloadData()
        
    }
    
    func getData(){
        var parameters = [String : AnyObject]()
        parameters["company.id"] = companyInfoModel.id
        
        NetworkTool.sharedTools.getCompanyInfo(parameters) { (data, error) in
            
            if error == nil{
                
                let childEconomyKindModels:[ChildEconomyKindModel] =   ChildEconomyKindModel.loadLocalModels()!
                let economyKindModels:[EconomyKindModel] =   EconomyKindModel.loadLocalModels()!
                let nationalEconomicModel:[NationalEconomicModel] = NationalEconomicModel.loadLocalModels()!
                let childNationalEconomicModel:[ChildNationalEconomicModel] = ChildNationalEconomicModel.loadLocalModels()!
                let companyScaleModel:[CompanyScaleModel] = CompanyScaleModel.loadLocleModels()!
                
                var economicType1Name:String!
                var economicType2Name:String!
                
                for item in economyKindModels{
                    if item.code == data.economicType1{
                        print("item.name = \(item.name)")
                    economicType1Name = item.name
                    }
                }
                for item in childEconomyKindModels{
                    if item.code == data.economicType2{
                         print("item.name = \(item.name)")
                        economicType2Name = item.name
                    }
                }
                data.jjlxName = economicType2Name ?? economicType1Name
                
                var naEcoType1:String!
                var naEcoType2:String!
                
                for item in nationalEconomicModel{
                    if item.code == data.naEcoType1{
                         print("item.name = \(item.name)")
                        naEcoType1 = item.name
                    }
                }
                
                for item in childNationalEconomicModel{
                    if item.code == data.naEcoType2{
                         print("item.name = \(item.name)")
                       naEcoType2 = item.name
                    }
                }
                
                data.gmjjlxName = naEcoType2 ?? naEcoType1
                
                for item in companyScaleModel{
                    if item.code == data.productionScale{
                         print("item.name = \(item.name)")
                        data.qygmName = item.name
                    }
                }
                
                self.companyInfoModel = data
                self.setData(self.companyInfoModel)
        
                
            }else{
                if error == NOTICE_SECURITY_NAME {
                    self.toLogin()
                }else{
                    self.showHint(error, duration: 2.0, yOffset: 2.0)
                }
            }
            
        }
    }
    
    
    func passParams(text: String,key:String,indexPaths: [NSIndexPath]) {
        companyInfoModel.setValue(text, forKey: key)
        self.cells = self.companyInfoModel.getCells()
        self.customTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
    }
    
    override func viewWillAppear(animated: Bool) {
        if (customTableView.indexPathForSelectedRow != nil) {
            customTableView.deselectRowAtIndexPath(customTableView.indexPathForSelectedRow!, animated: true)
        }
        self.navigationController?.navigationBar
                       .setBackgroundImage(UIImage(named: "set_head"), forBarMetrics: .Default)

    }
    
 
    
    func setData(data : CompanyInfoModel!){
        self.companyInfoModel = data
        self.secondArea = String(self.companyInfoModel.secondArea)
        self.thirdArea = String(self.companyInfoModel.thirdArea)
        self.parse.parse()
      //  self.companyInfoModel.areaName = combinedString ?? data.areaName
        self.cells = self.companyInfoModel.getCells()
        self.customTableView.reloadData()
    }
    
    //返回几节(组)
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.cells?.count)!
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.cells?[section]
        return data!.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier, forIndexPath: indexPath) as! CompanyInfoCell
        
        
        let secno = indexPath.section
        let _cell = self.cells![secno]![indexPath.row]
         cell.model = _cell
        
        if _cell.state != CellState.READ {
            cell.accessoryType = .DisclosureIndicator
        }else{
            cell.accessoryType = .None
        }
        return cell
    }
    
    //设置头部标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    //设置头部标题高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 8
        }
        return 0
    }
    
    //设置行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.cells![indexPath.section]![indexPath.row]
        customTableView.deselectRowAtIndexPath(customTableView.indexPathForSelectedRow!, animated: true)
        switch cell.state {
        case CellState.READ:
            break
        case .ENUM:
            self.showHint("test", duration: 1, yOffset: 1)
        case .TEXT:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BaseEditTextController") as! BaseEditTextController
            controller.indexPaths = [indexPath]
            controller.cell = cell
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        case .MULTI_TEXT:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BaseMultiTextController") as! BaseMultiTextController
            controller.indexPaths = [indexPath]
            controller.cell = cell
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
            default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     *  创建UITableView
     */
    func getTableView() -> UITableView{
        
        if customTableView == nil{
            customTableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: UITableViewStyle.Plain)
            let nib = UINib(nibName: ReuseIdentifier,bundle: nil)
            self.customTableView.registerNib(nib, forCellReuseIdentifier: ReuseIdentifier)
            customTableView?.delegate = self
            customTableView?.dataSource = self
            customTableView?.showsHorizontalScrollIndicator = false
            customTableView?.showsVerticalScrollIndicator = false
            customTableView?.tableFooterView = UIView()
            
        }
        
        return customTableView!
    }
    
    var areaArr = [String]()
    var combinedString : String = ""
    // 监听解析节点的属性
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        let code = attributeDict["code"]!as String
        let name = attributeDict["name"]! as String
        dictArea[code] = name
        dictArea[name] = code
        if attributeDict["code"]! == firstArea{
            firstAreaName = attributeDict["name"]! as String
            areaArr.append(firstAreaName)
        }
        if attributeDict["code"]! == secondArea{
            secondAreaName = attributeDict["name"]! as String
            areaArr.append(secondAreaName)
        }
        if attributeDict["code"]! == thirdArea{
            thirdAreaName = attributeDict["name"]! as String
            areaArr.append(thirdAreaName)
        }
      
        combinedString = areaArr.reduce("", combine: { (result, value) -> String in
            result + " " + value
        })
        
    }
}

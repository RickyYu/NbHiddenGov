//
//  TestController.swift
//  Mineral
//
//  Created by Ricky on 2017/3/23.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import UsefulPickerView

class ReprotHiddensController: SinglePhotoViewController, UITableViewDelegate, UITableViewDataSource,ParameterDelegate,MultiParameterDelegate,CompanyNameDelegate{
    let ReuseIdentifier = "ShopInfoCell"
    var cells: Dictionary<Int, [Cell]>? = [:]
    var dangerModel:DangerModel!
    var companyId:String!
    var customTableView:UITableView!
     let indexPaths: [NSIndexPath] = []
       var submitBtn = UIButton()
    var kMaxLength: Int  = 18
    var recordId:Int = -1
    var childDaIndustryModels : [ChildDaIndustryModel]!
    var parentDaIndustryModels : [ParentDaIndustryModel]!
    
    override func viewDidLoad() {
        setNavagation("一般隐患上报")
        customTableView = getTableView()
        self.view.addSubview(customTableView)
        if dangerModel == nil {
            getSystemTime({ (time) in
                self.dangerModel = DangerModel(createTime: time)
            })
            
        }
        
        let item=UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.saveInfo))
        self.navigationItem.rightBarButtonItem=item
        self.cells = dangerModel.getCells()
        self.customTableView.reloadData()
        
        getData()
        
    }
    
    func getData(){
        let parameters = [String : AnyObject]()
       // parameters["daNormalDanger.id"] = companyInfoModel.id

    NetworkTool.sharedTools.getDangerInfo(parameters) { (imageModels,childDaIndustryModels, parentDaIndustryModels, error) in
        if error == nil{
            self.childDaIndustryModels = childDaIndustryModels
            self.parentDaIndustryModels = parentDaIndustryModels
        
        }else{
            if error == NOTICE_SECURITY_NAME {
                self.toLogin()
            }else{
                self.showHint(error, duration: 2.0, yOffset: 2.0)
            }
        }
        }
    }

    func switchCode(hazardSourceName:String){
        switch hazardSourceName {
        case HAZARD_SOURCE_CODE[0]:
            self.dangerModel.hazardSourceName = HAZARD_SOURCE_NAME[0] //被输出
            self.startIndex = 0
        case HAZARD_SOURCE_CODE[1]:
            self.dangerModel.hazardSourceName = HAZARD_SOURCE_NAME[1]
            self.startIndex = 1
        case HAZARD_SOURCE_CODE[2]:
            self.dangerModel.hazardSourceName = HAZARD_SOURCE_NAME[2]
            self.startIndex = 2
        case HAZARD_SOURCE_CODE[3]:
            self.dangerModel.hazardSourceName = HAZARD_SOURCE_NAME[3]
            self.startIndex = 3
        default:break
        }
    }
    
    func passParams(text: String,key:String,indexPaths: [NSIndexPath]) {
        dangerModel.setValue(text, forKey: key)
        self.cells = self.dangerModel.getCells()
        self.customTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
    }
    
    func passCompanyInfo(text: String, companyId: String, key: String, indexPaths: [NSIndexPath]) {
        self.companyId = companyId
        dangerModel.setValue(text, forKey: key)
        self.cells = self.dangerModel.getCells()
        self.customTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
    }
    
    override func viewWillAppear(animated: Bool) {
        if (customTableView.indexPathForSelectedRow != nil) {
            customTableView.deselectRowAtIndexPath(customTableView.indexPathForSelectedRow!, animated: true)
        }
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
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    //设置行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 2  && indexPath.row == 6{

            return 160
        }
        return 45
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let secno = indexPath.section
        let _cell = self.cells![secno]![indexPath.row]
        
        if _cell.fieldName == "imageList"{
            let nib = UINib(nibName: "PhotoViewCell",bundle: nil)
            self.customTableView.registerNib(nib, forCellReuseIdentifier: "PhotoViewCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoViewCell", forIndexPath: indexPath) as! PhotoViewCell
            cell.scrollView.scrollEnabled = true
            cell.scrollView.showsHorizontalScrollIndicator = true
            cell.scrollView.showsVerticalScrollIndicator = false
            cell.scrollView.scrollsToTop = true
            cell.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 110)
            self.scrollView = cell.scrollView
            cell.photoView.addOnClickListener(self, action: #selector(takeImage))
            cell.selectionStyle = .None
            cell.accessoryType = .None
            cell.model = _cell
            //cell.imgView.setonCl
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier, forIndexPath: indexPath) as! ShopInfoCell
            if _cell.fieldName == "createTime"{
                cell.accessoryType = .None
            }else{
                cell.accessoryType = .DisclosureIndicator
            }
            cell.model = _cell
            return cell
        }
    }
    
    var defaultHiddenVlues:[String] = ["隐患类别","人","从业人员操作行为"]
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (customTableView.indexPathForSelectedRow != nil) {
            customTableView.deselectRowAtIndexPath(customTableView.indexPathForSelectedRow!, animated: true)
        }
        let cell = self.cells![indexPath.section]![indexPath.row]
        switch cell.state {
        case CellState.READ:
            break
        case .AREA: break
        case .ENUM:
            if cell.fieldName == "hazardSourceName"{
                choiceCreType([indexPath])
            }else if cell.fieldName == "repaired"{
            choiceZgState(startIndex,indexPaths: [indexPath])
            }else{ //隐患类别
                // 注意这里设置的是默认的选中值, 而不是选中的下标,省得去数关联数组里的下标
                UsefulPickerView.showMultipleAssociatedColsPicker("选择隐患", data: multipleAssociatedData, defaultSelectedValues: defaultHiddenVlues) {[unowned self] (selectedIndexs, selectedValues) in
//                    self.selectedDataLabel.text =
                    print("选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)")
                  
                    
                    for item in self.parentDaIndustryModels{
                        if item.name == selectedValues[1]{
                            self.dangerModel.industryId = item.id?.integerValue
                           
                        }
                    }
                    
                    for item in self.childDaIndustryModels{
                        if item.name == selectedValues[2]{
                     
                            self.dangerModel.secondIndustryId = item.id?.integerValue
                        }
                    }
                    self.defaultHiddenVlues.replaceRange(Range(0..<3), with: selectedValues)
                    self.dangerModel.yhTypeName = "\(selectedValues[1])  \(selectedValues[2])"
                    self.cells = self.dangerModel.getCells()
                    self.customTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)

                }
            }
            
        case .TEXT:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BaseEditTextController") as! BaseEditTextController
            controller.indexPaths = [indexPath]
            controller.cell = cell
            controller.delegate = self
            controller.cardNum = self.startIndex
            self.navigationController?.pushViewController(controller, animated: true)
        case .MULTI_TEXT:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("BaseMultiTextController") as! BaseMultiTextController
            controller.indexPaths = [indexPath]
            controller.cell = cell
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        case .TIME:
        self.choiceTime({ (time) in
            self.dangerModel.completedDate = time
            self.dangerModel.repaired = true
            self.dangerModel.zgStateStr = "已整改"
            self.startIndex = 1
            self.cells = self.dangerModel.getCells()
            self.customTableView.reloadData()
        })
        case .SKIP:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HisCompanyListController") as! HisCompanyListController
            controller.indexPaths = [indexPath]
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        default: break
            
        }
    }
    
    var startIndex:Int = 0 
    func choiceCreType(indexPaths: [NSIndexPath]){
        UsefulPickerView.showSingleColPicker("请选择", data: HAZARD_SOURCE_NAME, defaultSelectedIndex: startIndex) {[unowned self] (selectedIndex, selectedValue) in
            self.dangerModel.hazardSourceName = HAZARD_SOURCE_NAME[selectedIndex] //被输出
            self.dangerModel.hazardSourceCode = HAZARD_SOURCE_CODE[selectedIndex]
            self.startIndex = selectedIndex
            self.cells = self.dangerModel.getCells()
            self.customTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        }
    }
    
    func choiceZgState(startIndex:Int,indexPaths: [NSIndexPath]){
        UsefulPickerView.showSingleColPicker("请选择", data: ZG_STATE_NAME, defaultSelectedIndex: startIndex) {[unowned self] (selectedIndex, selectedValue) in
            if selectedValue == "已整改"{
            self.dangerModel.repaired = true
            self.dangerModel.zgStateStr = "已整改"
            }else{
                self.dangerModel.repaired = false
                self.dangerModel.zgStateStr = "未整改"
                self.dangerModel.completedDate = ""
            }
            self.startIndex = selectedIndex
            self.cells = self.dangerModel.getCells()
            self.customTableView.reloadData()
            //self.customTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func saveInfo(){
     
        if AppTools.isEmpty(dangerModel.descriptions) {
            alert("隐患描述不可为空!", handler: {
               // self.tfName.becomeFirstResponder()
            })
            return
        }
        
        if AppTools.isEmpty(dangerModel.yhTypeName) {
            alert("隐患类别不可为空!", handler: {
                //self.tfDocumentNum.becomeFirstResponder()
            })
            return
        }
        
        if AppTools.isEmpty(dangerModel.companyName) {
            alert("公司名称不可为空!", handler: {
               // self.tfProductName.becomeFirstResponder()
            })
            return
        }
        if AppTools.isEmpty(dangerModel.linkMan) {
            alert("隐患填报人不可为空!", handler: {
                //self.tfNum.becomeFirstResponder()
            })
            return
        }
        
        if !ValidateEnum.phoneNum(dangerModel.linkTel).isRight {
            alert("联系电话格式错误，请重新输入!", handler: {
                
            })
            return
        }
        
        if AppTools.isEmpty(dangerModel.completedDate) && dangerModel.repaired {
            alert("整改时间不可为空!", handler: {
                //self.tfNum.becomeFirstResponder()
            })
            return
        }
        
        var parameters = [String : AnyObject]()
        parameters["company.id"] = companyId
        if dangerModel.id != -1 {
            parameters["daNomalDanger.id"] = dangerModel.id
        }
        parameters["daNomalDanger.description"] = dangerModel.descriptions
        parameters["daNomalDanger.hazardSourceCode"] = dangerModel.hazardSourceCode  //证件编号
        parameters["daNomalDanger.type"] = "\(dangerModel.industryId)"//姓名
        parameters["daNomalDanger.secondType"] = "\(dangerModel.secondIndustryId)"//姓名
        parameters["daNomalDanger.repaired"] = "\(dangerModel.repaired)"//所在单位
        parameters["daNomalDanger.completedDate"] = dangerModel.completedDate//联系电话
        parameters["daNomalDanger.linkMan"] = dangerModel.linkMan
        parameters["daNomalDanger.linkTel"] = dangerModel.linkTel
        
        NetworkTool.sharedTools.saveInfo(parameters,imageArrays: getTakeImages()) { (login, error) in
            if error == nil{
                self.showHint("保存成功！", duration: 2.0, yOffset: 2.0)
                self.lastNavigationPage()
            }else{
                if error == NOTICE_SECURITY_NAME {
                    self.toLogin()
                }else{
                    self.showHint(error, duration: 2.0, yOffset: 2.0)
                }
            }
        }
    }
    

}

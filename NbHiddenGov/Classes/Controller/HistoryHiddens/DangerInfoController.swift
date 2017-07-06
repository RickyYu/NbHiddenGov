//
//  DangerInfoController.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//
import UIKit

class DangerInfoController:SinglePhotoViewController, UITableViewDelegate, UITableViewDataSource{
    
     var dangerInfoModel: DangerModel!
   var customTableView:UITableView!
    var companyInfoModel: CompanyInfoModel!
    var cells: Dictionary<Int, [Cell]>? = [:]
    var imageModels:[ImageModelVo]!
    
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        setNavagation("隐患详情")
        if !self.dangerInfoModel.repaired!{
            let item=UIBarButtonItem(title: "删除", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.deleteDanger))
            self.navigationItem.rightBarButtonItem=item
        }
        self.dangerInfoModel.yhTypeName = dangerInfoModel.industryText+"  "+dangerInfoModel.secondIndustryText
        self.dangerInfoModel.companyName = companyInfoModel.companyName
        customTableView = getTableView()
        self.view.addSubview(customTableView)
        getData()
    }
    
    func getData(){
        var parameters = [String : AnyObject]()
        parameters["daNomalDanger.id"] = dangerInfoModel.id
        NetworkTool.sharedTools.getDangerInfo(parameters) { (imageModels,childDaIndustryModels, parentDaIndustryModels, error) in
            if error == nil{
                self.imageModels = imageModels
                self.cells = self.dangerInfoModel.getCells()
                self.customTableView.reloadData()
            }else{
                if error == NOTICE_SECURITY_NAME {
                    self.toLogin()
                }else{
                    self.showHint(error, duration: 2.0, yOffset: 2.0)
                }
            }
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
            self.scrollView = cell.scrollView
            cell.scrollView.scrollEnabled = true
            cell.scrollView.showsHorizontalScrollIndicator = true
            cell.scrollView.showsVerticalScrollIndicator = false
            cell.scrollView.scrollsToTop = true
            cell.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 110)
            
            for o in imageModels {
                let imageView = UIImageView()
                self.loadImage(imageView, o.path)
                imageView.image?.accessibilityIdentifier = String(o.id)
                self.addImageView(imageView,isDelete: false)
            }
            
            cell.photoView.image =  UIImage(named: "defaul")
            cell.selectionStyle = .None
            cell.accessoryType = .None
            cell.model = _cell
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
    
    
    func deleteDanger(){
        self.alertNotice("提示", message: "请确定是否删除该记录？") {
            var parameters = [String : AnyObject]()
            parameters["daNomalDanger.id"] = self.dangerInfoModel.id
            NetworkTool.sharedTools.deleteDanger(parameters, finished: { (data, error) in
                if error == nil{
                    self.showHint("删除成功", duration: 1.0, yOffset: 1.0)
                    self.navigationController?.popViewControllerAnimated(true)
                    
                }else{
                    if error == NOTICE_SECURITY_NAME {
                        self.toLogin()
                    }else{
                        self.showHint(error, duration: 2.0, yOffset: 2.0)
                    }
                }
            })
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
    
}

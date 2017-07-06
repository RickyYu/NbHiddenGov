//
//  HistCompanyListController.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//

import Foundation
//反向传值
protocol CompanyNameDelegate{
    func passCompanyInfo(text: String,companyId:String,key:String,indexPaths: [NSIndexPath])
}
class HisCompanyListController: CompanyListController{
    
    var delegate:CompanyNameDelegate!
    var indexPaths: [NSIndexPath] = []
    @IBOutlet weak var hisCpyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.searchBar.placeholder = "请输入企业名称进行筛选"
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model:CompanyInfoModel = models[indexPath.row]
        
        if((self.delegate) != nil)
        {
            self.delegate.passCompanyInfo(model.companyName,companyId:"\(model.id)",key:"companyName",indexPaths: self.indexPaths)
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SaleRecordsListController") as! SaleRecordsListController
            controller.companyInfoModel = model
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
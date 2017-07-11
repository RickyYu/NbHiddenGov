//
//  CompanyListController.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/6/16.
//  Copyright © 2017年 safetys. All rights reserved.
//

import UIKit

class CompanyListController: BaseSearchViewController,UITableViewDelegate,UITableViewDataSource {
   let ReuseIdentifier = "SaleRecordsCell"
    @IBOutlet weak var tableView: UITableView!
    var models = [CompanyInfoModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+PAGE_SIZE
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
 
    
    var btnHome:UIButton!
    
    var searchStr : String! = ""
    
    override func viewDidLoad() {
        setNavagation("企业选择")
        initView()
    }
    
    func initView(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "set_head.png"), forBarMetrics: .Default)
        // 设置tableview相关
        let nib = UINib(nibName: ReuseIdentifier,bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: ReuseIdentifier)
        tableView.rowHeight = 53;
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        baseTableView = tableView
        countrySearchController = getSearchController()
        getData(true)
    
    }
    
    var isShowProgress = true
    
    //1、第一次进入，存储数据进行显示。获取更多时候，不存储后续数据，这样每一次都能保证缓存的是第一次加载数据
    //2、后续进入，先获取本地数据显示，后台异步加载。加载的如果和当前一样，则等于，不一样则追加
    //3、
    func getData(isLoadLocal:Bool){
        if isLoadLocal {
            if let array = CompanyInfoModel.loadLocalCompanyInfoModels(){
                self.models = array
                isShowProgress = false
            }
        }else{
            isShowProgress = true

        }
        var parameters = [String : AnyObject]()
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        if !AppTools.isEmpty(searchStr){
            parameters["company.companyName"] = searchStr

        }
   
        NetworkTool.sharedTools.getCompanyList(parameters,isShowProgress:isShowProgress,isLoadLocal:isLoadLocal) { (data, error,totalCount) in
            if error == nil{
                self.totalCount = totalCount!
                if self.currentPage>totalCount{
                    self.currentPage -= PAGE_SIZE
                    return
                }
                self.toLoadMore = false
                if self.models.count != 0 && isLoadLocal{//避免相同数据叠加
                    self.models = data
                }else{
                    self.models += data!
                }
                
                self.tableView.reloadData()
            }else{
                // 获取数据失败后
                self.currentPage -= PAGE_SIZE
                if self.toLoadMore{
                    self.toLoadMore = false
                }
                if error == NOTICE_SECURITY_NAME {
                    self.toLogin()
                }else{
                    self.showHint(error, duration: 2.0, yOffset: 2.0)
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier, forIndexPath: indexPath) as! SaleRecordsCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let count = models.count ?? 0
        if count > 0 {
            let model = models[indexPath.row]
            cell.model = model
        }
        //自动下拉加载
        
        if count > 0 && indexPath.row == count-1 && !toLoadMore && totalCount>PAGE_SIZE{
            toLoadMore = true
            currentPage += PAGE_SIZE
            getData(false)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CompanyInfoController") as! CompanyInfoController
      //  controller.companyInfoModel = models[indexPath.row]
        controller.companyId = models[indexPath.row].id
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    // MARK: - 内部控制方法
    /**
     重置数据
     */
    func reSet(){
        // 重置当前页
        currentPage = 0
        totalCount = 0
        // 重置数组
        models.removeAll()
        models = [CompanyInfoModel]()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if editingStyle == .Delete {
//            let recordId = models[indexPath.row].id
//            models.removeAtIndex(indexPath.row)
//            deleteRecord(recordId)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//        
//    }
    
//    func deleteRecord(recordId:Int){
//        var parameters = [String : AnyObject]()
//        parameters["sxsRecord.id"] = String(recordId)
//        parameters["type"] = TYPE_CODE
//        NetworkTool.sharedTools.deleteSaleRecord(parameters) { (data, error) in
//            if error == nil{
//                self.tableView.reloadData()
//            }else{
//                
//                if error == NOTICE_SECURITY_NAME {
//                    self.toLogin()
//                }else{
//                    self.showHint(error, duration: 2.0, yOffset: 2.0)
//                }
//            }
//        }
//    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        controller.searchBar.showsCancelButton = true
        findCancel()
        searchBar.resignFirstResponder()
        searchStr = countrySearchController.searchBar.text
        reSet()
        getData(false)
    }
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchStr = ""
        if models.count < PAGE_SIZE{
            reSet()
            getData(false)
        }
       
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchStr = searchText
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        controller.searchBar.showsCancelButton = true
        findCancel()
    }
}


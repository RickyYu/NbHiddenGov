//
//  SaleRecordsListController.swift
//  Mineral
//
//  Created by Ricky on 2017/3/21.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
class SaleRecordsListController: BaseSearchViewController,UITableViewDelegate,UITableViewDataSource{
    let ReuseIdentifier = "SaleRecordsCell"
    @IBOutlet weak var table: UITableView!
    
    var models = [DangerModel]()
    var companyInfoModel:CompanyInfoModel!
    // 当前页
    var currentPage : Int = 0  //加载更多时候+PAGE_SIZE
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    var btnHome:UIButton!
    override func viewDidLoad() {
        setNavagation("历史隐患查询")
        initView()
    }
    
    
    func initView(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "set_head.png"), forBarMetrics: .Default)
        // 设置tableview相关
        let nib = UINib(nibName: ReuseIdentifier,bundle: nil)
        self.table.registerNib(nib, forCellReuseIdentifier: ReuseIdentifier)
        table.rowHeight = 53;
        table.backgroundColor = UIColor.whiteColor()
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        baseTableView = table
        countrySearchController = getSearchController()
        countrySearchController.searchBar.placeholder = "请输入隐患描述进行筛选"
    }
    
    override func viewWillAppear(animated: Bool) {
        reSet()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
    }
    

  var searchStr : String! = ""
    func getData(){
        var parameters = [String : AnyObject]()
        parameters["company.id"] = companyInfoModel.id
        parameters["pagination.pageSize"] = PAGE_SIZE
        parameters["pagination.itemCount"] = currentPage
        parameters["pagination.totalCount"] = totalCount
        if !AppTools.isEmpty(searchStr){
            parameters["daNomalDanger.description"] = searchStr
            
        }

        NetworkTool.sharedTools.getDangerList(parameters) { (data, error,totalCount) in
            if error == nil{
                self.totalCount = totalCount!
                if self.currentPage>totalCount{
                    self.currentPage -= PAGE_SIZE
                    return
                }
                self.toLoadMore = false
                self.models += data!
                self.table.reloadData()
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
            cell.dangerModel = model
        }
        //自动下拉加载
        if count > 0 && indexPath.row == count-1 && !toLoadMore && totalCount>PAGE_SIZE{
            toLoadMore = true
            currentPage += PAGE_SIZE
            getData()
        }
        return cell
    }

    
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let controller = DangerInfoController()
         controller.dangerInfoModel = models[indexPath.row]
        controller.companyInfoModel = companyInfoModel
        table.deselectRowAtIndexPath(table.indexPathForSelectedRow!, animated: true)
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
        models = [DangerModel]()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchStr = countrySearchController.searchBar.text
        reSet()
        getData()
    }
    
    // 取消按钮触发事件
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchStr = ""
        if models.count < PAGE_SIZE{
            reSet()
            getData()
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

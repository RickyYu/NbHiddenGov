//
//  BaseSearchViewController.swift
//  NbHiddenGov
//
//  Created by Ricky on 2017/7/6.
//  Copyright © 2017年 safetys. All rights reserved.
//
class BaseSearchViewController: BaseViewController,UISearchBarDelegate {
    
    var baseTableView:UITableView!
    var controller = UISearchController(searchResultsController: nil)
    //搜索控制器
    var countrySearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    
    func getSearchController() -> UISearchController{
            controller.searchBar.delegate = self  //两个样例使用不同的代理
            controller.searchBar.showsCancelButton = true
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = true
            if #available(iOS 9.1, *) {
                controller.obscuresBackgroundDuringPresentation = true
            } else {
                // Fallback on earlier versions
            }
            controller.hidesNavigationBarDuringPresentation = true
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "请输入筛选条件"
            baseTableView.tableHeaderView = controller.searchBar
            self.definesPresentationContext = true
            return controller
    }
    
    func findCancel() {
        let btn = controller.searchBar.valueForKey("_cancelButton")! as! UIButton
        if btn.isKindOfClass(NSClassFromString("UINavigationButton")!){
            let cancel = btn
            ///设置按钮颜色
            //          cancel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            //          cancel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
            cancel.setTitle("取消", forState: UIControlState.Normal)
        }
    }
}
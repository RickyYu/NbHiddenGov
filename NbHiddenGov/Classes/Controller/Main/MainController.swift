//
//  MainController.swift
//  Mineral
//
//  Created by Ricky on 2017/3/9.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class MainController: BaseViewController{

    // 是否加载更多
    private var toLoadMore = false
    override func viewDidLoad() {
        setNavagation("")
           
       self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "set_head.png"), forBarMetrics: .Default)
    }
    
    override func viewWillAppear(animated: Bool) {
       self.navigationController?.navigationBar.hidden = true
    }
}


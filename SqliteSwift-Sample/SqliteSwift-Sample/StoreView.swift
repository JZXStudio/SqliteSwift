//
//  StoreView.swift
//  SqliteSwift
//
//  Created by SONG JIN on 2025/4/23.
//
import UIKit
import Foundation

import Aquarius

class StoreView: AView {
    public let storeTableView: UITableView = A.ui.tableView
    
    @objc dynamic
    private var updateAddTagSuccess: Bool = false {
        willSet {
            if newValue {
                storeTableView.reloadData()
            }
        }
    }
    
    override func a_UI() {
        super.a_UI()
        
        addSubview(storeTableView)
    }
    
    override func a_UIConfig() {
        super.a_UIConfig()
        
        storeTableView.register(StoreCell.self, forCellReuseIdentifier: "StoreCell")
        storeTableView.sectionHeaderHeight = 1.0
        storeTableView.sectionFooterHeight = 1.0
    }
    
    override func a_Layout() {
        super.a_Layout()
        
        storeTableView.size(sizes: [screenWidth(), screenHeight()])
        storeTableView.equalZeroTopAndLeft()
    }
    
    override func a_Bind() {
        super.a_Bind()
        
        bindTo(bindKey: BindParameters.bindTag_AddTag, attribute: #keyPath(updateAddTagSuccess))
    }
}

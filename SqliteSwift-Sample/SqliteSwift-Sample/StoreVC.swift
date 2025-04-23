//
//  StoreVC.swift
//  SqliteSwift
//
//  Created by SONG JIN on 2025/4/23.
//
import UIKit
import Foundation

import SwipeCellKit

import Aquarius

class StoreVC: AViewController {
    private let a_view: StoreView = StoreView()
    private let viewModel: StoreVM = StoreVM()
    
    override func a_Navigation() {
        super.a_Navigation()
        
        navigation_Title = "Store Sample"
        navigation_RightBarButtonImage = UIImage(systemName: "plus")
        navigation_RightBarButtonAction = #selector(rightButtonClick)
    }
    
    override func a_UI() {
        super.a_UI()
        
        addRootView(view: a_view)
    }
    
    override func a_Delegate() {
        super.a_Delegate()
        
        viewModel.Manage_SetDelegate(
            targetObject: a_view.storeTableView,
            delegateNames: AProtocol.delegateAndDataSource,
            object: self
        )
    }
    
    @objc
    func rightButtonClick() {
        viewModel.addNewTag()
    }
}

extension StoreVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StoreCell.storeCellHeight
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath))as! StoreCell
        
        if cell.delegate == nil {
            cell.delegate = self
        }
        
        cell.configWithCell(cellData: viewModel.tags[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension StoreVC: SwipeTableViewCellDelegate {
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        if orientation == .right {
            let completeAction = SwipeAction(style: .default, title: "删除") { [weak self] action, indexPath in
                let model: TagModel = self!.viewModel.tags[indexPath.row]
                self?.viewModel.removeTag(model.id)
            }
            completeAction.backgroundColor = .red
            completeAction.textColor = .white
            completeAction.font = 18.0.toBoldFont
            completeAction.transitionDelegate = ScaleTransition.default
            completeAction.hidesWhenSelected = true
            
            return [completeAction]
        }

        return nil
    }
    
    public func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        options.buttonSpacing = 0.0
        options.buttonPadding = 0.0
        options.transitionStyle = .reveal
        options.backgroundColor = .red
        return options
    }
}

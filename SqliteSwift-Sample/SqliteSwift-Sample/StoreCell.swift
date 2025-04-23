//
//  StoreCell.swift
//  SqliteSwift-Sample
//
//  Created by SONG JIN on 2025/4/23.
//
import UIKit
import Foundation

import Aquarius

class StoreCell: ASwipeCell {
    private let storeLabel: UILabel = A.ui.label
    
    public static let storeCellHeight: CGFloat = 48.0
    
    override func a_UI() {
        super.a_UI()
        
        addSubviewInContentView(view: storeLabel)
    }
    
    override func a_UIConfig() {
        super.a_UIConfig()
        
        storeLabel.textColor = .black
        storeLabel.font = 16.0.toBoldFont
        storeLabel.textLeftAlignment()
    }
    
    override func a_Layout() {
        super.a_Layout()
        
        storeLabel.size(sizes: [screenWidth() - 16.0*2, StoreCell.storeCellHeight])
        storeLabel.equalZeroTop()
        storeLabel.left(left: 16.0)
    }
    
    override func configWithCell(cellData: Any) {
        super.configWithCell(cellData: cellData)
        
        let model: TagModel = cellData as! TagModel
        
        storeLabel.text = model.name
    }
}

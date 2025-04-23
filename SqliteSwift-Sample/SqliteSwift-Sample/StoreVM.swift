//
//  StoreVM.swift
//  SqliteSwift
//
//  Created by SONG JIN on 2025/4/23.
//

import Foundation

import Aquarius

class StoreVM: AViewModel {
    public var tags: [TagModel] = []
    
    @objc dynamic
    private var bindTag_AddTagSuccess: Bool = false
    
    private let tagImpl: TagServiceImpl = TagServiceImpl()
    
    override func a_Begin() {
        super.a_Begin()
        
        updateData()
    }
    
    override func a_Bind() {
        super.a_Bind()
        
        bindFrom(bindKey: BindParameters.bindTag_AddTag, attribute: #keyPath(bindTag_AddTagSuccess))
    }
    
    private func updateData() {
        tags.removeAll()
        
        tags = tagImpl.selectAll()
    }
    
    private func refreshData() {
        updateData()
        
        A_true(&bindTag_AddTagSuccess)
    }
    
    public func addNewTag() {
        var model: TagModel = TagModel()
        model.name = String.random(length: 8)
        if tagImpl.save(model: model)! > 0 {
            refreshData()
        }
    }
    
    public func removeTag(_ tagID: Int) {
        if tagImpl.delete(id: tagID)! > 0 {
            refreshData()
        }
    }
}

//
//  LabelImpl.swift
//  YueNoteDataFramework
//
//  Created by SONG JIN on 2023/12/5.
//

import Foundation

public struct TagServiceImpl {
    private let service: TagService = TagService()
    
    public init() {
        
    }
    
    public func selectAll() -> Array<TagModel> {
        return service.selectAll()
    }
    
    public func select(tagName: String) -> Bool {
        return service.selectTag(tagName: tagName)
    }
    
    public func select(tagNames: Array<String>) -> Array<String> {
        return service.selectTagName(tagIDs: tagNames)
    }
    
    public func save(model: TagModel) -> Int? {
        return service.insert(model: model)
    }
    
    public func update(model: TagModel) -> Int? {
        return service.update(model: model)
    }
    
    public func delete(id: Int) -> Int? {
        return service.delete(tagID: id)
    }
}

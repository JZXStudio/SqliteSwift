//
//  LabelService.swift
//  YueNoteDataFramework
//
//  Created by SONG JIN on 2023/12/5.
//

import Foundation

import SQLite

internal struct TagService {
    let sqlite: SqliteSwift = SqliteSwift(dbName: DatabaseInfo.DATABASE_NAME, model: TagTable())
    
    public func selectAll() -> Array<TagModel> {
        let results = sqlite.selectAll()
        var array: Array<TagModel> = []
        for dict: Dictionary<String, Any> in results {
            let model: TagModel = TagModel(id: dict.getIntValue("id"),
                                             name: dict.getStringValue("name"))
            
            array.append(model)
        }
        
        return array
    }
    
    public func selectTag(tagName: String) -> Bool {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<String>(TagTableInfo.C_NAME) == tagName)
        let result = sqlite.select(condition: predicate)
        return result.count > 0 ? true : false
    }
    
    public func selectTagName(tagIDs: Array<String>) -> Array<String> {
        var predicate: SQLite.Expression<Bool>!
        var index: Int = 0
        for tagID: String in tagIDs {
            if index == 0 {
                predicate = (SQLite.Expression<String>(TagTableInfo.C_NAME) == tagID)
            } else {
                predicate = predicate || (SQLite.Expression<String>(TagTableInfo.C_NAME) == tagID)
            }
            
            index = index + 1
        }
        
        let result = sqlite.select(condition: predicate)
        if result.count == 0 {
            return []
        } else {
            var array: Array<String> = []
            for dict: Dictionary<String, Any> in result {
                array.append(dict.getStringValue("name"))
            }
            return array
        }
    }
    
    public func insert(model: TagModel) -> Int? {
        return sqlite.insert(model: model)
    }
    
    public func update(model: TagModel) -> Int? {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int>(TagTableInfo.C_ID) == model.id)
        return sqlite.update(model: model, condition: predicate)
    }
    @discardableResult
    public func delete(tagID: Int) -> Int? {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int>(TagTableInfo.C_ID) == tagID)
        return sqlite.delete(condition: predicate)
    }
}

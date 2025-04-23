//
//  SqliteSwiftModelBase.swift
//  TestDefault
//
//  Created by SONG JIN on 2022/8/19.
//

import Foundation

import SQLite
//456
open class SqliteSwiftModelBase: NSObject, SqliteSwiftModelProtocol {
    public var id: Int = -1
    
    private var keys: Array<String> = Array()
    
    private var sqlite: SqliteSwift
    private var tableModel: Any
    
    public var asyncSql: Bool = false
    
    public static let defaultInt: Int = 0
    public static let defaultString: String = ""
    public static let defaultBool: Bool = false
    public static let defaultDate: Date = Date()
    
    deinit {
        if asyncSql {
            configObserver(enabled: false)
        }
    }
    
    public init(dbName: String, tableModel: Any, async: Bool) {
        self.tableModel = tableModel
        sqlite = SqliteSwift(dbName: dbName, model: tableModel)
        asyncSql = async
        
        super.init()
        
        configObserver(enabled: async)
    }
    
    public func asyncEnabled(enabled: Bool) -> Void {
        asyncSql = enabled
        
        configObserver(enabled: enabled)
    }
    
    private func configObserver(enabled: Bool) -> Void {
        if enabled {
            let mirror: Mirror = Mirror(reflecting: self)
            for child in mirror.children {
                let label: String = child.label.unsafelyUnwrapped
                addObserver(self, forKeyPath: label, options: [.new], context: nil)
                keys.append(label)
            }
        } else {
            for currentKey: String in keys {
                removeObserver(self, forKeyPath: currentKey, context: nil)
            }
        }
    }
    
    public func selectAll() -> Array<Dictionary<String, Any>> {
        return sqlite.selectAll()
    }
    
    public func selectAllAndPage(pageCount: Int, currentPage: Int = 0) -> Array<Dictionary<String, Any>> {
        return sqlite.selectAllLimit(limit: pageCount, offset: currentPage)
    }
    
    @discardableResult
    public func select() -> Array<Dictionary<String, Any>> {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int64>("id") == Int64(truncatingIfNeeded: self.id))
        return sqlite.select(condition: predicate)
    }
    
    public func selectCondition(predicate: SQLite.Expression<Bool>) -> Array<Dictionary<String, Any>> {
        return sqlite.select(condition: predicate)
    }
    
    public func selectCondition(predicate: SQLite.Expression<Bool>, pageCount: Int, currentPage: Int) -> Array<Dictionary<String, Any>> {
        return sqlite.select(condition: predicate, limit: pageCount, offset: currentPage)
    }
    
    public func insert() -> Int {
        return Int(sqlite.insert(model: self)!)
    }
    
    public func update() -> Void {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int64>("id") == Int64(truncatingIfNeeded: self.id))
        sqlite.update(model: self, condition: predicate)
    }
    
    public func delete() -> Void {
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int64>("id") == Int64(truncatingIfNeeded: self.id))
        sqlite.delete(condition: predicate)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if id == -1 {
            return
        }
        let predicate: SQLite.Expression<Bool> = (SQLite.Expression<Int64>("id") == Int64(truncatingIfNeeded: id))
        sqlite.update(model: self, condition: predicate)
    }
}

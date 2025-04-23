//
//  SqliteSwift.swift
//  TestDefault
//
//  Created by SONG JIN on 2022/8/17.
//

import SQLite
import Foundation

public enum SqliteSwiftOrderType {
    case DESC
    case ASC
}

public typealias ExpressionInt = SQLite.Expression<Int>
public typealias ExpressionInt_ = SQLite.Expression<Int?>
public typealias ExpressionInt64 = SQLite.Expression<Int64>
public typealias ExpressionInt64_ = SQLite.Expression<Int64?>
public typealias ExpressionBool = SQLite.Expression<Bool>
public typealias ExpressionBool_ = SQLite.Expression<Bool?>
public typealias ExpressionDouble = SQLite.Expression<Double>
public typealias ExpressionDouble_ = SQLite.Expression<Double?>
public typealias ExpressionString = SQLite.Expression<String>
public typealias ExpressionString_ = SQLite.Expression<String?>
public typealias ExpressionDate = SQLite.Expression<Date>
public typealias ExpressionDate_ = SQLite.Expression<Date?>
public typealias ExpressionData = SQLite.Expression<Data>
public typealias ExpressionData_ = SQLite.Expression<Data?>
public typealias ExpressionBlob = SQLite.Expression<Blob>
public typealias ExpressionBlob_ = SQLite.Expression<Blob?>
public typealias ExpressionAny = SQLite.Expression<Any>
public typealias ExpressionAny_ = SQLite.Expression<Any?>

open class SqliteSwift: NSObject {
    private var dbName: String
    private var db: Connection?
    private var table: Table
    private var tableModel: Any
    
    static let kPrimaryKey: String = "primaryKey"
    static let kUnique: String = "unique"
    static let kTableName: String = "tableName"
    static let kTableModel: String = "tableModel"
    
    deinit {
        
    }
    
    public init(dbName: String, model: Any) {
        self.dbName = dbName
        self.tableModel = model
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        db = try? Connection("\(path)/\(dbName).sqlite3")
        let p_class: SqliteSwiftTableProtocol = tableModel as! SqliteSwiftTableProtocol
        table = Table(p_class.tableName)
        
        super.init()
        
        let mirror = Mirror(reflecting: model.self)
        
        //let propertys: Array<String> = mirror.children.compactMap { $0.label }
        
        try! db?.run(table.create(ifNotExists: true, block: { (table) in
            let primaryKeyMirror = Mirror(reflecting: p_class.primaryKey.self)
            var primaryKeyMirrorTemp: String = ""
            for primaryKeyChild in primaryKeyMirror.children {
                if primaryKeyChild.label == "template" {
                    primaryKeyMirrorTemp = primaryKeyChild.value as! String
                    break
                }
            }
            
            for child in mirror.children {
                if child.label != SqliteSwift.kPrimaryKey && child.label != SqliteSwift.kUnique && child.label != SqliteSwift.kTableName  {
                    let mirror2 = Mirror(reflecting: child.value.self)
                    
                    if mirror2.subjectType == ExpressionInt.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionInt, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionInt, unique: true)
                        } else {
                            table.column(child.value as! ExpressionInt)
                        }
                    } else if mirror2.subjectType == ExpressionInt_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionInt, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionInt_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionInt_)
                        }
                    } else if mirror2.subjectType == ExpressionInt64.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionInt64, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionInt64, unique: true)
                        } else {
                            table.column(child.value as! ExpressionInt64)
                        }
                    } else if mirror2.subjectType == ExpressionInt64_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionInt64, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionInt64_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionInt64_)
                        }
                    } else if mirror2.subjectType == ExpressionString.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionString, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionString, unique: true)
                        } else {
                            table.column(child.value as! ExpressionString)
                        }
                    } else if mirror2.subjectType == ExpressionString_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionString, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionString_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionString_)
                        }
                    } else if mirror2.subjectType == ExpressionBool.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionBool, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionBool, unique: true)
                        } else {
                            table.column(child.value as! ExpressionBool)
                        }
                    } else if mirror2.subjectType == ExpressionBool_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionBool, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionBool_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionBool_)
                        }
                    } else if mirror2.subjectType == ExpressionDouble.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionDouble, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionDouble, unique: true)
                        } else {
                            table.column(child.value as! ExpressionDouble)
                        }
                    } else if mirror2.subjectType == ExpressionDouble_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionDouble, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionDouble_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionDouble_)
                        }
                    } else if mirror2.subjectType == ExpressionBlob.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionBlob, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionBlob, unique: true)
                        } else {
                            table.column(child.value as! ExpressionBlob)
                        }
                    } else if mirror2.subjectType == ExpressionBlob_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionBlob, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionBlob_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionBlob_)
                        }
                    } else if mirror2.subjectType == ExpressionDate.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionDate, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionDate, unique: true)
                        } else {
                            table.column(child.value as! ExpressionDate)
                        }
                    } else if mirror2.subjectType == ExpressionDate_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionDate, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionDate_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionDate_)
                        }
                    } else if mirror2.subjectType == ExpressionData.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionData, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionData, unique: true)
                        } else {
                            table.column(child.value as! ExpressionData)
                        }
                    } else if mirror2.subjectType == ExpressionData_.self {
                        if checkPrimaryKey(_value: child.value, currentKey: primaryKeyMirrorTemp) {
                            table.column(child.value as! ExpressionData, primaryKey: true)
                        } else if checkUnique(_value: child.value, unique: p_class.unique) {
                            table.column(child.value as! ExpressionData_, unique: true)
                        } else {
                            table.column(child.value as! ExpressionData_)
                        }
                    }
                }
            }
        }))
    }
    
    private func checkPrimaryKey(_value: Any, currentKey: String) -> Bool {
        var result: Bool = false
        
        let mirror = Mirror(reflecting: _value.self)
        var mirrorTemp: String = ""
        
        for child in mirror.children {
            if child.label == "template" {
                mirrorTemp = child.value as! String
                break
            }
        }
        
        if mirrorTemp != "" && currentKey != "" && mirrorTemp == currentKey {
            result = true
        }
        
        return result
    }
    
    private func checkUnique(_value: Any, unique: Array<Any>) -> Bool {
        var result: Bool = false
        
        let mirror = Mirror(reflecting: _value.self)
        var mirrorTemp: String = ""
        
        for child in mirror.children {
            if child.label == "template" {
                mirrorTemp = child.value as! String
                break
            }
        }
        
        for currentUnique: Any in unique {
            let mirror2 = Mirror(reflecting: currentUnique.self)
            var mirror2Temp: String = ""
            
            var flag: Bool = false
            for child2 in mirror2.children {
                if child2.label == "template" {
                    mirror2Temp = child2.value as! String
                    flag = true
                    
                    if mirror2Temp != "" && mirrorTemp != "" && mirror2Temp == mirrorTemp {
                        result = true
                    }
                    break
                }
            }
            if flag {
                break
            }
        }
        
        return result
    }
    //MARK: 直接返回123
    public func runQuery(_ queryString: String) -> Statement? {
        return (try! db?.run(queryString))
    }
    
    public func prepareQuery(_ queryString: String) -> Statement? {
        return (try! db?.prepare(queryString))
    }
    
    public func selectAll() -> Array<Dictionary<String, Any>> {
        let query = table
        
        return selectResult(query)
    }
    
    public func selectAll(order: ExpressionAny, type: SqliteSwiftOrderType = .DESC) -> Array<Dictionary<String, Any>> {
        let query = type == .DESC ? table.order(order.desc) : table.order(order.asc)
        
        return selectResult(query)
    }
    
    public func selectAllLimit(limit: Int, offset: Int = 0) -> Array<Dictionary<String, Any>> {
        let query = table.limit(limit, offset: offset)
        
        return selectResult(query)
    }
    
    public func selectAllLimit(limit: Int, offset: Int = 0, order: ExpressionAny, type: SqliteSwiftOrderType = .DESC) -> Array<Dictionary<String, Any>> {
        let query = type == .DESC ? table.limit(limit, offset: offset).order(order.desc) : table.limit(limit, offset: offset).order(order.asc)
        
        return selectResult(query)
    }
    
    public func select(condition: ExpressionBool) -> Array<Dictionary<String, Any>> {
        let query = table.filter(condition)
        
        return selectResult(query)
    }
    
    public func select(condition: ExpressionBool, limit: Int, offset: Int = 0) -> Array<Dictionary<String, Any>>  {
        let query = table.filter(condition).limit(limit, offset: offset)
        
        return selectResult(query)
    }
    
    public func select(condition: ExpressionBool, limit: Int, offset: Int = 0, order: ExpressionAny, type: SqliteSwiftOrderType = .DESC) -> Array<Dictionary<String, Any>>  {
        let query = type == .DESC ? table.filter(condition).limit(limit, offset: offset).order(order.desc) : table.filter(condition).limit(limit, offset: offset).order(order.asc)
        
        return selectResult(query)
    }
    
    private func selectResult(_ query: QueryType) -> Array<Dictionary<String, Any>> {
        var result: Array<Dictionary<String, Any>> = Array()
        //查询
        for tableData in (try! db?.prepare(query))! {
            var dict: Dictionary<String, Any> = [:]
            
            let mirror = Mirror(reflecting: tableModel.self)
            for child in mirror.children {
                let childLabel: String = child.label.unsafelyUnwrapped
                if childLabel == SqliteSwift.kPrimaryKey || childLabel == SqliteSwift.kUnique || childLabel == SqliteSwift.kTableName || childLabel == SqliteSwift.kTableModel {
                    continue
                }
                let mirror2 = Mirror(reflecting: child.value)
                if mirror2.subjectType == ExpressionInt.self {
                    dict[childLabel] = tableData[child.value as! ExpressionInt] as Int
                } else if mirror2.subjectType == ExpressionInt_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionInt_]! as Int
                } else if mirror2.subjectType == ExpressionInt64.self {
                    dict[childLabel] = tableData[child.value as! ExpressionInt64] as Int64
                } else if mirror2.subjectType == ExpressionInt64_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionInt64_]! as Int64
                } else if mirror2.subjectType == ExpressionString.self {
                    dict[childLabel] = tableData[child.value as! ExpressionString] as String
                } else if mirror2.subjectType == ExpressionString_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionString_]! as String
                } else if mirror2.subjectType == ExpressionBool.self {
                    dict[childLabel] = tableData[child.value as! ExpressionBool] as Bool
                } else if mirror2.subjectType == ExpressionBool_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionBool_]! as Bool
                } else if mirror2.subjectType == ExpressionDouble.self {
                    dict[childLabel] = tableData[child.value as! ExpressionDouble] as Double
                } else if mirror2.subjectType == ExpressionDouble_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionDouble_]! as Double
                } else if mirror2.subjectType == ExpressionData.self {
                    dict[childLabel] = tableData[child.value as! ExpressionData] as Data
                } else if mirror2.subjectType == ExpressionData_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionData_]! as Data
                } else if mirror2.subjectType == ExpressionDate.self {
                    dict[childLabel] = tableData[child.value as! ExpressionDate] as Date
                } else if mirror2.subjectType == ExpressionDate_.self {
                    dict[childLabel] = tableData[child.value as! ExpressionDate_]! as Date
                }
            }
            
            result.append(dict)
        }
        
        return result
    }
    
    public func selectCount() -> Int {
        return (try! db?.scalar(table.count))!
    }
    
    public func selectCount(condition: ExpressionBool) -> Int {
        return (try! db?.scalar(table.count.filter(condition)))!
    }
    
    @discardableResult
    public func insert(model: Any) -> Int? {
        let insertSetters: Array<Setter> = assembleSetters(model: model)
        
        let insert = table.insertMany([insertSetters])
        let rowid = Int(try! (db?.run(insert))!)
        
        return rowid
    }
    
    @discardableResult
    public func update(model:Any, condition: ExpressionBool) -> Int? {
        let updateSetters: Array<Setter> = assembleSetters(model: model)
        
        let update = table.filter(condition)
        let rowid = try! db?.run(update.update(updateSetters))
        
        return rowid
    }
    
    @discardableResult
    public func delete(condition: ExpressionBool) -> Int? {
        //删除
        let rowid = try! db?.run(self.table.filter(condition).delete())
        
        return rowid
    }
    //MARK: 闭包函数
    @discardableResult
    public func insert(model: Any, completion:@escaping ((_ success : Bool) -> Void)) -> Self {
        let insertSetters: Array<Setter> = assembleSetters(model: model)
        
        let insert = table.insertMany([insertSetters])
        
        do {
            try db?.run(insert)
            completion(true)
        } catch {
            completion(false)
        }
        
        return self
    }
    @discardableResult
    public func update(model:Any, condition: ExpressionBool, completion:@escaping ((_ success : Bool) -> Void)) -> Self {
        let updateSetters: Array<Setter> = assembleSetters(model: model)
        
        let update = table.filter(condition)
        
        do {
            try db?.run(update.update(updateSetters))
            completion(true)
        } catch {
            completion(false)
        }
        
        return self
    }
    @discardableResult
    public func delete(condition: ExpressionBool, completion:@escaping ((_ success : Bool) -> Void)) -> Self {
        //删除
        do {
            try db?.run(table.filter(condition).delete())
            completion(true)
        } catch {
            completion(false)
        }
        
        return self
    }
    
    private func assembleSetters(model: Any) -> Array<Setter> {
        var setters: Array<Setter> = Array()
        let mirror = Mirror(reflecting: model.self)
        for child in mirror.children {
            let childLabel: String = child.label.unsafelyUnwrapped
            if childLabel == "C_ID" || childLabel == "id" {
                continue
            }
            var isDBName: Bool = false
            if child.value is String {
                if child.value as! String == self.dbName {
                    isDBName = true
                }
            }
            if isDBName || childLabel == SqliteSwift.kTableName || childLabel == SqliteSwift.kPrimaryKey || childLabel == SqliteSwift.kUnique || childLabel == SqliteSwift.kTableModel {
                continue
            }
            let modelTemp: Any = getModelMirrorValue(model: tableModel, key: childLabel)!
            let mirror2 = Mirror(reflecting: modelTemp.self)
            if mirror2.subjectType == ExpressionInt.self {
                setters.append(modelTemp as! SQLite.Expression<Int> <- child.value as! Int)
            } else if mirror2.subjectType == ExpressionInt_.self {
                setters.append(modelTemp as! SQLite.Expression<Int?> <- child.value as? Int)
            } else if mirror2.subjectType == ExpressionInt64.self {
                setters.append(modelTemp as! SQLite.Expression<Int64> <- child.value as! Int64)
            } else if mirror2.subjectType == ExpressionInt64_.self {
                setters.append(modelTemp as! SQLite.Expression<Int64?> <- child.value as? Int64)
            } else if mirror2.subjectType == ExpressionString.self {
                setters.append(modelTemp as! SQLite.Expression<String> <- child.value as! String)
            } else if mirror2.subjectType == ExpressionString_.self {
                setters.append(modelTemp as! SQLite.Expression<String?> <- child.value as? String)
            } else if mirror2.subjectType == ExpressionBool.self {
                setters.append(modelTemp as! SQLite.Expression<Bool> <- child.value as! Bool)
            } else if mirror2.subjectType == ExpressionBool_.self {
                setters.append(modelTemp as! SQLite.Expression<Bool?> <- child.value as? Bool)
            } else if mirror2.subjectType == ExpressionDouble.self {
                setters.append(modelTemp as! SQLite.Expression<Double> <- child.value as! Double)
            } else if mirror2.subjectType == ExpressionDouble_.self {
                setters.append(modelTemp as! SQLite.Expression<Double?> <- child.value as? Double)
            } else if mirror2.subjectType == ExpressionData.self {
                setters.append(modelTemp as! SQLite.Expression<Data> <- child.value as! Data)
            } else if mirror2.subjectType == ExpressionData_.self {
                setters.append(modelTemp as! SQLite.Expression<Data?> <- child.value as? Data)
            } else if mirror2.subjectType == ExpressionDate.self {
                setters.append(modelTemp as! SQLite.Expression<Date> <- child.value as! Date)
            } else if mirror2.subjectType == ExpressionDate_.self {
                setters.append(modelTemp as! SQLite.Expression<Date?> <- child.value as? Date)
            }
        }
        
        return setters
    }
    
    private func getModelMirrorValue(model: Any, key: String) -> Any? {
        var result: Any?
        
        let mirror = Mirror(reflecting: model.self)
        for child in mirror.children {
            if child.label.unsafelyUnwrapped == key {
                //let mirror2 = Mirror(reflecting: child.value.self)
                result = child.value
                break
            }
        }
        
        return result
    }
}
/*
 public static func expressionAny(_ expression: String) -> ExpressionAny {
     return ExpressionAny(expression)
 }
 */

public struct A_Expression {
    private var expression: String
    
    public init(_ expression: String) {
        self.expression = expression
    }
    
    public var any: ExpressionAny {
        get {
            ExpressionAny(expression)
        }
    }
    
    public var any_: ExpressionAny_ {
        get {
            ExpressionAny_(expression)
        }
    }
    
    public var string: ExpressionString {
        get {
            ExpressionString(expression)
        }
    }
    
    public var string_: ExpressionString_ {
        get {
            ExpressionString_(expression)
        }
    }
    
    public var bool: ExpressionBool {
        get {
            ExpressionBool(expression)
        }
    }
    
    public var bool_: ExpressionBool_ {
        get {
            ExpressionBool_(expression)
        }
    }
    
    public var double: ExpressionDouble {
        get {
            ExpressionDouble(expression)
        }
    }
    
    public var double_: ExpressionDouble_ {
        get {
            ExpressionDouble_(expression)
        }
    }
    
    public var int: ExpressionInt {
        get {
            ExpressionInt(expression)
        }
    }
    
    public var int_: ExpressionInt_ {
        get {
            ExpressionInt_(expression)
        }
    }
    
    public var int64: ExpressionInt64 {
        get {
            ExpressionInt64(expression)
        }
    }
    
    public var int64_: ExpressionInt64_ {
        get {
            ExpressionInt64_(expression)
        }
    }
    
    public var data: ExpressionData {
        get {
            ExpressionData(expression)
        }
    }
    
    public var data_: ExpressionData_ {
        get {
            ExpressionData_(expression)
        }
    }
    
    public var date: ExpressionDate {
        get {
            ExpressionDate(expression)
        }
    }
    
    public var date_: ExpressionDate_ {
        get {
            ExpressionDate_(expression)
        }
    }
    
    public var blob: ExpressionBlob {
        get {
            ExpressionBlob(expression)
        }
    }
    
    public var blob_: ExpressionBlob_ {
        get {
            ExpressionBlob_(expression)
        }
    }
}

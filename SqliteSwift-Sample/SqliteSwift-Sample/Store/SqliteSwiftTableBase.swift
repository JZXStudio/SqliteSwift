//
//  SqliteSwiftTableBase.swift
//  JZXSTools
//
//  Created by SONG JIN on 2023/12/7.
//

import Foundation

import SQLite

open class SqliteSwiftTableBase: NSObject, SqliteSwiftTableProtocol {
    public let C_ID: SQLite.Expression<Int64> = SQLite.Expression<Int64>("C_ID")
    /* 设置主键 */
    public var primaryKey: Any = SQLite.Expression<Int64>("C_ID")
    /* 设置unique约束 */
    public var unique: Array<Any> = []
    /* 设置表名 */
    public var tableName: String = ""
}

//
//  LabelTable.swift
//  YueNoteDataFramework
//
//  Created by SONG JIN on 2023/12/6.
//

import Foundation

import SQLite

open class TagTable: SqliteSwiftTableProtocol {
    public let id: SQLite.Expression<Int> = SQLite.Expression<Int>(TagTableInfo.C_ID)
    public let name = SQLite.Expression<String>(TagTableInfo.C_NAME)
    
    public var tableName: String = TagTableInfo.TABLE_NAME
    public var primaryKey: Any = SQLite.Expression<Int>(TagTableInfo.C_ID)
    public var unique: Array<Any> = []
}

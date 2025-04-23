//
//  DBModelProtocol.swift
//  TestDefault
//
//  Created by SONG JIN on 2022/8/17.
//

import Foundation

import SQLite

public protocol SqliteSwiftTableProtocol {
    var tableName: String { get set }
    var primaryKey: Any { get set }
    var unique: Array<Any> { get set }
}

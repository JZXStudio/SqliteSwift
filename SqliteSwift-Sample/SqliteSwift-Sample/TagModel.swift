//
//  LabelModel.swift
//  YueNoteDataFramework
//
//  Created by SONG JIN on 2023/12/5.
//

import Foundation

public struct TagModel {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public init() {
        self.id = -1
        self.name = ""
    }
}

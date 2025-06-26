//
//  Node.swift
//  MutableTableViewDemo
//
//  Created by 王杰 on 2025/6/26.
//

import Foundation

class Node {
    var id: String
    var parentID: String
    var name: String
    var level: Int = 1
    var isExpanded: Bool = false
    var isLeaf: Bool = true
    var isRoot: Bool = false

    init(id: String, parentID: String, name: String) {
        self.id = id
        self.parentID = parentID
        self.name = name
    }
}


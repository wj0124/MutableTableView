//
//  ViewController.swift
//  MutableTableViewDemo
//
//  Created by 王杰 on 2025/6/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let data: [Node] = [
            // 第一棵树
            Node(id: "1", parentID: "", name: "Node 1"),
            Node(id: "10", parentID: "1", name: "Node 1-0"),
            Node(id: "11", parentID: "1", name: "Node 1-1"),
            Node(id: "12", parentID: "1", name: "Node 1-2"),
            Node(id: "100", parentID: "10", name: "Node 1-0-0"),
            Node(id: "101", parentID: "10", name: "Node 1-0-1"),
            Node(id: "110", parentID: "11", name: "Node 1-1-0"),
            Node(id: "111", parentID: "11", name: "Node 1-1-1"),
            Node(id: "1000", parentID: "100", name: "Node 1-0-0-0"),
            Node(id: "1001", parentID: "100", name: "Node 1-0-0-1"),
            Node(id: "1110", parentID: "111", name: "Node 1-1-1-0"),
            
            // 第二棵树
            Node(id: "2", parentID: "", name: "Node 2"),
            Node(id: "20", parentID: "2", name: "Node 2-0"),
            Node(id: "21", parentID: "2", name: "Node 2-1"),
            Node(id: "22", parentID: "2", name: "Node 2-2"),
            Node(id: "200", parentID: "20", name: "Node 2-0-0"),
            Node(id: "201", parentID: "20", name: "Node 2-0-1"),
            Node(id: "210", parentID: "21", name: "Node 2-1-0"),
            Node(id: "211", parentID: "21", name: "Node 2-1-1"),
            Node(id: "2000", parentID: "200", name: "Node 2-0-0-0"),
            Node(id: "2001", parentID: "200", name: "Node 2-0-0-1"),
            Node(id: "2100", parentID: "210", name: "Node 2-1-0-0"),
            
            // 第三棵树
            Node(id: "3", parentID: "", name: "Node 3"),
            Node(id: "30", parentID: "3", name: "Node 3-0"),
            Node(id: "31", parentID: "3", name: "Node 3-1"),
            Node(id: "300", parentID: "30", name: "Node 3-0-0"),
            Node(id: "301", parentID: "30", name: "Node 3-0-1"),
            Node(id: "310", parentID: "31", name: "Node 3-1-0"),
            Node(id: "311", parentID: "31", name: "Node 3-1-1"),
            Node(id: "3000", parentID: "300", name: "Node 3-0-0-0")
        ]
        
        let table = MultiLevelTableView(
            frame: CGRect(x: 20, y: 100, width: view.bounds.width, height: view.bounds.height - 140),
            nodes: data,
            rootID: "",
            select: { node in
                print("选中：\(node.name),\(node.id)")
            })
        
        view.addSubview(table)
        
        
    }


}



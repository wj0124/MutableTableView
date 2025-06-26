//
//  MultiLevelTableView.swift
//  MutableTableViewDemo
//
//  Created by 王杰 on 2025/6/26.
//

import UIKit

class MultiLevelTableView: UITableView {

    private var allNodes: [Node] = []
    private var displayNodes: [Node] = []
    private var selectBlock: ((Node) -> Void)?
    private let indentWidth: CGFloat = 20

    init(frame: CGRect, nodes: [Node], rootID: String = "", select: ((Node) -> Void)? = nil) {
        super.init(frame: frame, style: .plain)
        self.selectBlock = select
        setup(nodes: nodes, rootID: rootID)
        register(MultiLevelNodeCell.self, forCellReuseIdentifier: "MultiLevelNodeCell")
        delegate = self
        dataSource = self
        separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup(nodes: [Node], rootID: String) {
        allNodes = nodes

        // 标记 root 和 leaf
        for node in allNodes {
            node.isRoot = !allNodes.contains(where: { $0.id == node.parentID })
            node.isLeaf = !allNodes.contains(where: { $0.parentID == node.id })
        }

        // 设置 level
       // updateLevels(from: rootID.isEmpty ? nil : rootID, level: 1)
        
        //updateLevels(from: rootID.isEmpty ? "" : rootID, level: 1)
        
        let actualRootID = rootID.isEmpty ? "" : rootID
        updateLevels(from: actualRootID, level: 1)
        
        // 初始只加载根节点
        displayNodes = allNodes.filter { $0.isRoot }
    }

    private func updateLevels(from parentID: String?, level: Int) {
        for node in allNodes where node.parentID == parentID {
            node.level = level
            updateLevels(from: node.id, level: level + 1)
        }
    }

    private func children(of parent: Node) -> [Node] {
        return allNodes.filter { $0.parentID == parent.id }
    }

    private func collectExpandedDescendants(of parent: Node) -> [Node] {
        var result: [Node] = []
        for node in children(of: parent) {
            result.append(node)
            if node.isExpanded {
                result.append(contentsOf: collectExpandedDescendants(of: node))
            }
        }
        return result
    }
}

extension MultiLevelTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayNodes.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MultiLevelNodeCell", for: indexPath) as? MultiLevelNodeCell else {
            return UITableViewCell()
        }
        let node = displayNodes[indexPath.row]
        cell.configure(with: node, indentWidth: indentWidth)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = displayNodes[indexPath.row]

        if node.isLeaf {
            selectBlock?(node)
            return
        }

        node.isExpanded.toggle()

        tableView.reloadRows(at: [indexPath], with: .none)

        
        if node.isExpanded {
            let descendants = collectExpandedDescendants(of: node)
            guard !descendants.isEmpty else { return }

            let insertIndex = indexPath.row + 1
            displayNodes.insert(contentsOf: descendants, at: insertIndex)

            let indexPaths = (0..<descendants.count).map {
                IndexPath(row: insertIndex + $0, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .fade)

        } else {
            let descendants = collectExpandedDescendants(of: node)
            guard !descendants.isEmpty else { return }

            let range = (indexPath.row + 1)..<(indexPath.row + 1 + descendants.count)
            displayNodes.removeSubrange(range)

            let indexPaths = descendants.enumerated().map { (offset, _) in
                IndexPath(row: indexPath.row + 1 + offset, section: 0)
            }
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        
    }
}



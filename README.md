# MultiLevelTableView

基于 Swift + UIKit 实现的多级可折叠列表组件，支持无限层级嵌套结构，节点展开/收起带动画效果，采用局部插入与删除方式，性能优秀，适用于组织架构、分类目录、地区选择等场景。

## ✨ 功能特性

- [x] 无限层级节点嵌套支持
- [x] 支持折叠 / 展开操作，状态可持续
- [x] 展开时递归插入所有展开节点（支持多层）
- [x] 局部刷新 UI，避免整表 reload，提高性能
- [x] 使用系统 SFSymbol 图标展示折叠状态（＋/－）
- [x] 支持节点点击回调
- [x] 使用方式简单，0 依赖，纯 UIKit 环境可直接集成

## 🖼️ 效果预览
![IMG_6791](https://github.com/user-attachments/assets/e15a2e29-340e-454d-ad0f-190dbb77fc45)




> 

## 🧱 使用方式

### 初始化数据

```swift
let data: [Node] = [
    Node(id: "1", parentID: "", name: "北京"),
    Node(id: "10", parentID: "1", name: "海淀区"),
    Node(id: "100", parentID: "10", name: "中关村"),
    Node(id: "2", parentID: "", name: "上海"),
    Node(id: "20", parentID: "2", name: "徐汇区")
    // ... 支持任意层级嵌套
]
```

### 添加到界面中

```swift
let table = MultiLevelTableView(
    frame: CGRect(x: 20, y: 100, width: view.bounds.width, height: view.bounds.height - 140),
    nodes: data,
    rootID: "",
    select: { node in
        print("选中：\(node.name), ID: \(node.id)")
    }
)
view.addSubview(table)
```

## 🧩 Node 数据结构说明

```swift
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
```

## 📦 项目结构

- `Node.swift`：节点数据模型
- `MultiLevelTableView.swift`：主控件，处理树结构与交互逻辑
- `MultiLevelNodeCell.swift`：自定义 Cell，展示节点信息与图标
- `ViewController.swift`：测试用例与使用示例

## 🛠️ TODO（可选）

- [ ] 添加懒加载节点数据支持
- [ ] 折叠/展开图标支持旋转动画
- [ ] 支持节点长按、编辑等交互
- [ ] 支持全收起/全展开功能

---

如有建议、问题或改进意见，欢迎提 Issue 或 PR 🙌

📬 如有问题可联系作者：wangjie7629@163.com

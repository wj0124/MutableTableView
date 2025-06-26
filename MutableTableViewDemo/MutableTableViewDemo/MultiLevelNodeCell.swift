//
//  MultiLevelNodeCell.swift
//  MutableTableViewDemo
//
//  Created by 王杰 on 2025/6/26.
//

import UIKit

class MultiLevelNodeCell: UITableViewCell {

    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)

        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit

        nameLabel.font = .systemFont(ofSize: 16)
    }

    func configure(with node: Node, indentWidth: CGFloat) {
        let leftOffset = CGFloat(node.level - 1) * indentWidth

        if !node.isLeaf {
            let symbolName = node.isExpanded ? "minus.circle" : "plus.circle"
            iconImageView.image = UIImage(systemName: symbolName)
            iconImageView.frame = CGRect(x: leftOffset, y: 12, width: 20, height: 20)
            iconImageView.isHidden = false
        } else {
            iconImageView.isHidden = true
        }

        let labelX = leftOffset + (node.isLeaf ? 0 : 28)
        nameLabel.text = node.name
        nameLabel.frame = CGRect(x: labelX, y: 0, width: contentView.bounds.width - labelX - 16, height: 44)
    }
}


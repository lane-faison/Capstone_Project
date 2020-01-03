//
//  GoalOptionTableViewCell.swift
//  MissionPR
//
//  Created by Lane Faison on 12/21/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

class GoalTextFieldTableViewCell: UITableViewCell, ConfigurableCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: GoalTextFieldCellViewModel) {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
    }
    
}

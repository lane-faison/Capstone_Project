//
//  TitleButtonView.swift
//  MissionPR
//
//  Created by Lane Faison on 12/4/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class TitleButtonView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    var iconButtonTapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        addSubview(iconButton)
        iconButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        iconButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TitleButtonViewModel) {
        titleLabel.text = viewModel.title
        iconButton.setBackgroundImage(viewModel.buttonImage.tinted(tintColor: .darkGray), for: .normal)
        iconButtonTapAction = viewModel.buttonTapAction
        
        iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
    }
}

extension TitleButtonView {
    
    @objc private func iconButtonTapped() {
        iconButtonTapAction?()
    }
}

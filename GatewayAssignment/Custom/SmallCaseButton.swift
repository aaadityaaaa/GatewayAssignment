//
//  SmallCaseButton.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

class SmallCaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backGroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: backGroundColor, title: title)
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
    }
    
   final func set(color: UIColor, title: String) {
       backgroundColor = color
       setTitleColor(.white, for: .normal)
       setTitle(title, for: .normal)
    }
    
}



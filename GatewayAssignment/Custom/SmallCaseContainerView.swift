//
//  SmallCaseContainerView.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import Foundation
import UIKit

class SmallCaseContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       layer.cornerRadius = 16
       layer.borderWidth = 2
       layer.borderColor = UIColor.white.cgColor
       translatesAutoresizingMaskIntoConstraints = false
       backgroundColor = .systemBackground
    }

}

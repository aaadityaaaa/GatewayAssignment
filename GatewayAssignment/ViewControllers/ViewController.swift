//
//  ViewController.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var appBrowserButton: UIButton = {
        let button = UIButton(configuration: .tinted(), primaryAction: nil)
        button.addTarget(self, action: #selector(browserButtonTapped(_:)), for: .touchUpInside)
        button.setTitle("Open in App Browser", for: .normal)
        return button
    }()
    
    private lazy var callApiButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.addTarget(self, action: #selector(callApiButtonTapped(_:)), for: .touchUpInside)
        button.setTitle("Call API", for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemFill
        setupViews()
    }
    
    
    private func setupViews() {
        view.addSubview(appBrowserButton)
        view.addSubview(callApiButton)
        
        appBrowserButton.pinLeading(withPadding: 50)
        appBrowserButton.pinTrailing(withPadding: -50)
        appBrowserButton.constrainHeight(equalTo: 60)
        appBrowserButton.centerY()
        
        callApiButton.constrainHeight(equalTo: 60)
        callApiButton.pinTopToBottom(of: appBrowserButton, withSpacing: 20)
        callApiButton.pinLeading(withPadding: 50)
        callApiButton.pinTrailing(withPadding: -50)
        
    }


}

extension ViewController {
    
    @objc private func browserButtonTapped(_ sender: UIButton) {
        print("Browser button was tapped")
    }
    
    @objc private func callApiButtonTapped(_ sender: UIButton) {
        print("Call Api button was tapped")
    }
    
}

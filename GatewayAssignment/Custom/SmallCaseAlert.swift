//
//  SmallCaseAlert.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import Foundation
import UIKit

class SmallCaseAlert: UIViewController {
    
    let containerView = SmallCaseContainerView()
    let titleLabel = SmallCaseTitleLabel(textAlignment: .center, fontSize: 18)
    let messageLabel = SmallCaseBodyLabel(textAlignment: .left)
    let actionButton = SmallCaseButton(backGroundColor: .green.withAlphaComponent(0.5), title: "OK")
    let copyButton = SmallCaseButton(backGroundColor: .yellow.withAlphaComponent(0.5), title: "Copy")

    var alertTitle: String?
    var message: String?
    var isCopyAllowed: Bool = false
    var copyText: String = ""
    
    let padding: CGFloat = 20
    
    
    init(alertTitle: String, message: String, isCopyAllowed : Bool, copyText: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.isCopyAllowed = isCopyAllowed
        self.copyText = copyText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureUI()
    }
    
    
    func configureUI() {
        configureContainer()
        configureTitleLabel()
        configureActionButton()
        if isCopyAllowed {
            configureCopyButton()
        }
        configureBodyLabel()
    }
    
    func configureContainer() {
        view.addSubview(containerView)
        containerView.pinTop(withPadding: 150)
        containerView.pinBottom(withPadding: -150)
        containerView.constrainWidth(equalTo: 300)
        containerView.centerX()
        containerView.backgroundColor = .white
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        titleLabel.pinTop(withPadding: 20)
        titleLabel.pin(edges: .leading(padding: 20), .trailing(padding: -20))
        titleLabel.centerX()
        titleLabel.textColor = .black
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle("OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.pinBottom(to: containerView, withPadding: -20)
        actionButton.constrainHeight(equalTo: 45)
        actionButton.constrainWidth(equalTo: 269)
        actionButton.centerX()
    }
    
    func configureCopyButton() {
        containerView.addSubview(copyButton)
        copyButton.setTitle("Copy", for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        copyButton.pinBottomToTop(of: actionButton, withSpacing: -20)
        copyButton.constrainHeight(equalTo: 45)
        copyButton.constrainWidth(equalTo: 269)
        copyButton.centerX()
    }
    
    func configureBodyLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 0
        messageLabel.pinTopToBottom(of: titleLabel, withSpacing: 8)
        messageLabel.pin(edges: .leading(padding: 10), .trailing(padding: -10))
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func copyButtonTapped() {
        ToastBasic.make(with: ToastBasic.Configuration(backgroundColor: .purple.withAlphaComponent(0.6), htmlText: nil, text: "successfully copied", font: .systemFont(ofSize: 16), textColor: .white, borderConfig: nil)).show(at: .bottom, offset: nil, duration: 1.2, completion: nil)
        UIPasteboard.general.string = copyText
    }
   

}

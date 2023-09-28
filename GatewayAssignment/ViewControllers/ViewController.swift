//
//  ViewController.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

class ViewController: LoadingVC {
    
    var viewModel: MainViewModel
    
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
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemFill
        setupViews()
        viewModel.percentEncodeJSON()
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
        viewModel.openURLInApp { url in
            print("SO WE ARE GETTING THE URL INSIDE OUR VIEW CONTROLLER NOW \(url)")
            let statusString = url.absoluteString.slice(from: "status=", to: "&")
            let codeString = url.absoluteString.slice(from: "code=", to: "&")
            self.presentSmallCaseAlertOnMainThread(
                title: "Status : " + (statusString ?? "ERROR"),
                message: "Code : " + (codeString ?? "ERROR"),
                buttonTitle: "Ok",
                isCopyAllowed: false,
                isJSONPresent: true,
                copyText: self.viewModel.percentDecodeJSON(urlString: url.absoluteString),
                heightOfContainer: 250
            )
        }
    }
    
    @objc private func callApiButtonTapped(_ sender: UIButton) {
        viewModel.fetchData(view: self) { output in
            self.presentSmallCaseAlertOnMainThread(title: "JSON DATA", message: output, buttonTitle: "Ok", isCopyAllowed: true, isJSONPresent: false, copyText: output, heightOfContainer: 550)
        }
    }
    
}

extension UIViewController {
    func presentSmallCaseAlertOnMainThread(title: String, message: String, buttonTitle: String, isCopyAllowed: Bool, isJSONPresent: Bool, copyText: String, heightOfContainer: CGFloat) {
        DispatchQueue.main.async {
            let alertVC = SmallCaseAlert(alertTitle: title, message: message, isCopyAllowed: isCopyAllowed, isJSONPresent: isJSONPresent, copyText: copyText, heightOfContainer: heightOfContainer)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(alertVC, animated: true)
        }
        
    }
}

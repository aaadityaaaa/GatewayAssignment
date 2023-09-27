//
//  ToastView.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 28/09/23.
//

import UIKit

public class ToastBasic: UIView, ToastView {
    
    public struct ToastBorderConfiguration {
        var borderColor: UIColor?
        var borderWidth: CGFloat
        var showShadow: Bool = false
    }
    
    public struct Configuration {
        let backgroundColor: UIColor?
        let htmlText: String?
        let text: String?
        let font: UIFont?
        let textColor: UIColor?
        var borderConfig: ToastBorderConfiguration?
        var showDismissButton: Bool = false
        var textAlignment: NSTextAlignment = .center
        var dismissBtnIcon: UIImage? = UIImage(named: "cross_btn")
    }
    
    private (set) lazy var toastLabel: UILabel = {
        let toastLabel = UILabel()
        toastLabel.font = .systemFont(ofSize: 16)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        return toastLabel
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross_btn"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(toastLabel)

        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            toastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            toastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        toastLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 64
    }

    // This class function to make an Object is inspired from Android.
    public class func make(text: String) -> ToastBasic {
        let content = ToastBasic(frame: CGRect.zero)
        content.toastLabel.text = text
        return content
    }
    
    public class func make(with configuration: Configuration) -> ToastBasic {
        let content = ToastBasic(frame: CGRect.zero)
        content.backgroundColor = configuration.backgroundColor
        
        if let htmlText = configuration.htmlText, let _ = configuration.font,
           let _ = configuration.textColor {
            content.toastLabel.attributedText = NSAttributedString(string: htmlText)
            content.toastLabel.textColor = configuration.textColor
        } else {
            content.toastLabel.text = configuration.text
            content.toastLabel.font = configuration.font
            content.toastLabel.textColor = configuration.textColor
            content.toastLabel.textAlignment = configuration.textAlignment
        }
        
        if let borderConfig = configuration.borderConfig {
            content.layer.borderColor = borderConfig.borderColor?.cgColor
            content.layer.borderWidth = borderConfig.borderWidth
            
            if borderConfig.showShadow {
                content.layer.masksToBounds = false
                content.layer.shadowColor = UIColor.black.cgColor
                content.layer.shadowOpacity = 0.5
                content.layer.shadowOffset = CGSize(width: -1, height: 1)
                content.layer.shadowRadius = 1
            }
        }
        
        if configuration.showDismissButton {
            content.dismissButton.setImage(configuration.dismissBtnIcon, for: .normal)
            NSLayoutConstraint.deactivate(content.toastLabel.constraints)
            content.toastLabel.removeFromSuperview()
            
            content.addSubview(content.toastLabel)
            setupConstraintWithDismissBtn(in: content)
        }
        return content
    }
    
    private class func setupConstraintWithDismissBtn(in content: ToastBasic) {
        
        content.addSubview(content.dismissButton)
        
        NSLayoutConstraint.activate([
            content.toastLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            content.toastLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            content.toastLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16),
            
            content.dismissButton.heightAnchor.constraint(equalToConstant: 24),
            content.dismissButton.widthAnchor.constraint(equalToConstant: 24),
            content.dismissButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            content.dismissButton.centerYAnchor.constraint(equalTo: content.toastLabel.centerYAnchor)
        ])
    }
    
    @objc func dismissTapped() {
        self.alpha = 0
        self.removeFromSuperview()
    }
}


public class ToastError: ToastBasic {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }

    public class func make(error text: String) -> ToastError {
        let content = ToastError(frame: CGRect.zero)
        content.toastLabel.text = text
        return content
    }
}


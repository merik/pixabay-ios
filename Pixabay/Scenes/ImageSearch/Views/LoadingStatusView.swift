//
//  LoadingView.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class LoadingStatusView: UIView {
    
    private var loadingView: UIView!
    private var messageLabel: UILabel!
    
    private var indicator: UIActivityIndicatorView!
    private var loadingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        self.indicator = indicator
        
        let label = UILabel()
        label.text = "Loading"
        label.textAlignment = .left
        self.loadingLabel = label
        
        let view = UIView()
        self.loadingView = view
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(indicator)
        view.addSubview(label)
        
        let messageLabel = UILabel()
        messageLabel.text = ""
        messageLabel.textAlignment = .center
        self.messageLabel = messageLabel
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        self.addSubview(messageLabel)
        
        configureConstraints()
        
        hide()
    }
    
    private func configureConstraints() {
        let constraints = [
            loadingView.widthAnchor.constraint(equalToConstant: 80),
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: indicator.trailingAnchor, constant: 5),
            loadingLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor),
            loadingLabel.heightAnchor.constraint(equalToConstant: 21),
            loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            messageLabel.topAnchor.constraint(equalTo: topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    var status: ImageSearchResult = .searching {
        didSet {
            switch status {
            case .searching:
                showLoading()
            case .error(let message):
                showError(message)
            case .notFound:
                showNoResults()
            case .success:
                hide()
            }
        }
    }
    
    private func showLoading() {
        self.isHidden = false
        self.messageLabel.isHidden = true
        self.loadingView.isHidden = false
    }
    
    private func showNoResults() {
        self.isHidden = false
        self.loadingView.isHidden = true
        self.messageLabel.isHidden = false
        self.messageLabel.text = "No Results"
    }
    
    private func hide() {
        self.isHidden = true
    }
    
    private func showError(_ message: String) {
        self.isHidden = false
        self.loadingView.isHidden = true
        self.messageLabel.isHidden = false
        self.messageLabel.text = message
       
    }
}

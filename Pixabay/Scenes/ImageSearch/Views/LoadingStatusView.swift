//
//  LoadingView.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class LoadingStatusView: UIView {
    
    // FIXME: Unable to simultaneously satisfy constraints.
    
    private var indicator: UIActivityIndicatorView!
    private var label: UILabel!
    
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
        self.label = label
        
        self.addSubview(indicator)
        self.addSubview(label)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        self.indicator.isHidden = false
        label.textAlignment = .left
        label.text = "Loading"
        resetConstraints()
        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: indicator.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 21),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func showNoResults() {
        self.isHidden = false
        self.indicator.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        resetConstraints()
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 21),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func resetConstraints() {
        //label.removeConstraints(label.constraints)
        //indicator.removeConstraints(indicator.constraints)
    }
    
    private func hide() {
        self.isHidden = true
    }
    
    private func showError(_ message: String) {
        self.isHidden = false
        self.indicator.isHidden = true
        label.textAlignment = .center
        label.text = message
        resetConstraints()
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 21),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

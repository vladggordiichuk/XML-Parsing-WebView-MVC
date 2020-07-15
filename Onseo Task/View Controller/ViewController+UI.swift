//
//  ViewController+UI.swift
//  Onseo Task
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

extension ViewController {
    
    internal func setUpElements() {
        
        view.addSubview(webView)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view.addSubview(activityView)
        
        activityView.startAnimating()
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

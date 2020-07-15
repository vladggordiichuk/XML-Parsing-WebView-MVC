//
//  ViewController.swift
//  Onseo Task
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    internal var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    internal var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        fetchXMLData()
    }
    
    internal func showAlertMessage(with message: String, isXMLRetry: Bool = false, isWebViewRetry: Bool = false) {
        
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        if isXMLRetry {
            
            let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self, weak alertViewController] _ in
                self?.fetchXMLData()
                alertViewController?.dismiss(animated: true, completion: nil)
            }
            
            alertViewController.addAction(retryAction)
        } else if isWebViewRetry {
            
            let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self, weak alertViewController] _ in
                self?.webView.reload()
                alertViewController?.dismiss(animated: true, completion: nil)
            }
            
            alertViewController.addAction(retryAction)
        } else {
            
            let okAction = UIAlertAction(title: "Got it", style: .default) { [weak alertViewController] _ in
                alertViewController?.dismiss(animated: true, completion: nil)
            }
            
            alertViewController.addAction(okAction)
        }
        
        present(alertViewController, animated: true)
    }
}

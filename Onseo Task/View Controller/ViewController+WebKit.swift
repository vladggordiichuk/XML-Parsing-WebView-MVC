//
//  ViewController+WebKit.swift
//  Onseo Task
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit
import WebKit

extension ViewController: WKNavigationDelegate, WKUIDelegate {
    
    internal func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        
        showAlertMessage(with: error.localizedDescription,
                         isWebViewRetry: true)
    }
    
    internal func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        
        showAlertMessage(with: message)
        
        completionHandler()
    }
    
    internal func webView(_ webView: WKWebView,
                 didFinish  navigation: WKNavigation!) {
        
        activityView.stopAnimating()
        
        webView.evaluateJavaScript("window.alert(\"Success\")", completionHandler: nil)
    }
}

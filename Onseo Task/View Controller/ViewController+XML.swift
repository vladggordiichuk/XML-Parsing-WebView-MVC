//
//  ViewController+XML.swift
//  Onseo Task
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

extension ViewController {
    
    internal func fetchXMLData() {
        
        if let url = URL(string: "http://bingoplayground.test.bingosys.net/native.xml") {
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 10
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
                if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    self?.processXMLData(data)
                } else if let error = error {
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.showAlertMessage(with: error.localizedDescription,
                                               isXMLRetry: true)
                    }
                }
            }.resume()
        }
    }
    
    internal func processXMLData(_ data: Data) {
        
        let xmlParser = LinkXMLParser(with: data)
        
        if let url = xmlParser.find("com.888bingo") {
            
            DispatchQueue.main.async { [weak self] in
                
                var request = URLRequest(url: url)
                request.timeoutInterval = 10
                
                self?.webView.load(request)
            }
        } else {
            
            DispatchQueue.main.async { [weak self] in
                self?.showAlertMessage(with: "Could not find appURL for bundle (com.888bingo)",
                                       isXMLRetry: true)
            }
        }
    }
}

//
//  LinkXMLParser.swift
//  Onseo Task
//
//  Created by Vlad Gordiichuk on 15.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

class LinkXMLParser: NSObject {
    
    init(with data: Data) {
        super.init()
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    private var apps = [App]()
    
    private var currentApp: App?
    private var currentElement: String?
}

extension LinkXMLParser: XMLParserDelegate {
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "app" {
            currentApp = App(bundle: "", appUrl: "")
        }
        
        currentElement = elementName
    }
    
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        guard currentApp != nil else { return }
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if currentElement == "bundle" {
                currentApp!.bundle += data
            } else if currentElement == "appURL" {
                currentApp!.appUrl += data
            }
        }
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard let app = currentApp else { return }
        
        if elementName == "app" {
            
            if !app.bundle.isEmpty && !app.appUrl.isEmpty {
                apps.append(app)
            }
            
            currentApp = nil
        }
    }
    
    internal func find(_ bundle: String) -> URL? {
        
        guard let urlStr = apps.first(where: { $0.bundle == bundle })?.appUrl else { return nil }
        
        guard let url = URL(string: urlStr) else { return nil }
        
        return url
    }
}

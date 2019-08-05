//
//  RSSParser.swift
//  CodaBee
//
//  Created by Bernard Masset on 23/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import Foundation

class RSSParser:NSObject, XMLParserDelegate {
    
    var articles: [Article] = []
    
    var title = ""
    var link = ""
    var pubDate = ""
    var imageUrl = ""
    
    var element = ""

    var completion: (([Article]) -> Void)?
    
    func parse(_ urlString: String, completion: (([Article]) -> Void)?) {
        self.completion = completion
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, rsponse, error) in
                if error == nil {
                    if let d = data {
                        let parser = XMLParser(data: d)
                        parser.delegate = self
                        parser.parse()
                    } else {
                        // On arrête tout
                        self.completion?(self.articles)
                    }
                } else {
                    self.completion?(self.articles)
                }
            }.resume()
            
        } else {
            // On arrête tout
            self.completion?(articles)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName

        if element == "item" {
            title = ""
            pubDate = ""
            link = ""
            imageUrl = ""
        }
        
        if element == "enclosure" {
            if let url = attributeDict["url"] {
                imageUrl = url
            }
        }
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch element {
        case "title" : title += string
        case "link" :
            if link == "" {
                link = string
            }
        case "pubDate" :
            if pubDate == "" {
                pubDate = string
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //
        if elementName == "item" {
            let new = Article(title: title, link: link, pubDate: pubDate, imageUrl: imageUrl)
            articles.append(new)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        // Envoyer les données
        self.completion?(articles)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // Arrêter
        print(parseError.localizedDescription)
        self.completion?(articles)
    }
}

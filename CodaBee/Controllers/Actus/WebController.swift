//
//  WebController.swift
//  CodaBee
//
//  Created by Bernard Masset on 25/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit
import WebKit

class WebController: UIViewController {
    
    //@IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    var loadingIV: LoadingImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let link = urlString, let url = URL(string: link) else { return }
        let urlRequest = URLRequest(url: url)
        
        webView.navigationDelegate = self
        
        // Création d'une animation
        loadingIV = LoadingImageView(frame: CGRect(x: view.frame.width / 2 - 75, y: 75, width: 150, height: 150))
        loadingIV?.start()
        if loadingIV != nil {
            view.addSubview(loadingIV!)
        }
        webView.load(urlRequest)
    }
}

extension WebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIV?.stop()
        loadingIV?.removeFromSuperview()
        loadingIV = nil
    }
}

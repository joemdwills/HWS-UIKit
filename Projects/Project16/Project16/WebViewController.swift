//
//  WebViewController.swift
//  Project16
//
//  Created by Joe Williams on 03/11/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var wikiSite: String?
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if wikiSite == "Washington DC" {
            url = URL(string: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        } else {
            let wiki = "https://en.wikipedia.org/wiki/"
            url = URL(string: wiki + (wikiSite)!)
        }
        
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

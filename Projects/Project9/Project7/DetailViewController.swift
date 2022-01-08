//
//  DetailViewController.swift
//  Project7
//
//  Created by Joe Williams on 27/09/2021.
//

import UIKit
import WebKit



class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        let html = """
            <hmtl>
            <head>
            <meta name="viewport" content="width=device=width, initial-scale=1">
            <style> title {font-size: 300%; } body { font-size: 150%; } </style>
            </head>
            <body>
              <h3>\(detailItem.title)</h3>
              <p>\(detailItem.body)</p>
            </body>
            </html>
            """
            
        webView.loadHTMLString(html, baseURL: nil)
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

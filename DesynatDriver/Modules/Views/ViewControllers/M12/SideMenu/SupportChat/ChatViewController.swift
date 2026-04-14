//
//  ChatViewController.swift
//  DesynatDriver
//
//  Created by fluper_mac3 on 13/04/26.
//


import UIKit
import WebKit

class ChatViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        view.addSubview(webView)

        // Fullscreen or frame as needed
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let html = """
        <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <body>
            <script src="//code.tidio.co/na5y0weklpcd9uxhccfezplsfg0fggvk.js" async></script>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    @IBAction func backDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

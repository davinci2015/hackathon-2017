//
//  WebViewController.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    private let url = URL(string: "http://foncoreapi.azurewebsites.net/memory.html")

    override func viewDidLoad() {
        super.viewDidLoad()
        openPage()
        navigationController?.navigationBar.isTranslucent = false
    }

    private func openPage() {
        if let url = url {
            let request = NSURLRequest(url: url)
            webView.loadRequest(request as URLRequest)
        }
    }

}

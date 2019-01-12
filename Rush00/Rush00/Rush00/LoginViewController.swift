//
//  LoginViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit
import WebKit


class LoginViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
//            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:mmoullec42ApiCredentials.URL)
//        let myURL = URL(string: "http://youtube.com")
        print(myURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        view = webView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func webView(didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
        print(self.webView!.url)
        if (self.webView!.url?.absoluteString == "https://myserver.com/successurl" )
        {
            print("SUCCESS")
            self.webView!.stopLoading()
            // do something here, like remove this from the nav controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func webView(didCommitNavigation navigation: WKNavigation!) {
        print("didCommitNavigation - content arriving?")
    }
    
    func webView(didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print("didFailNavigation")
    }
    
    func webView(didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation \(navigation)")
    }
    
    //    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    //        print("didFinishNavigation")
    //        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
    //                                   completionHandler: { (html: AnyObject?, error: NSError?) in
    //                                    print(html)
    //        })
    //    }
    
}

//
//  OAuth2ViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//


import UIKit
import WebKit

protocol oauthDelegate:class {
    func authorisation(success: Bool, token: String?)
}

class AuthorizationViewController: UIViewController, WKNavigationDelegate {
    
    weak var delegate: oauthDelegate?
    var startURL: URL?
    var interceptURLString: String = "authorize"
    var navigationIsFinished: Bool = false
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        clearCache()
        
        startURL = URL(string: mmoullec42ApiCredentials.URL)

        // TODO: Handle someone pressing on the back button or remove it
        
        // Do any additional setup after loading the view.
    }
    
    func clearCache() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    /// Called when the web view is about to be dismissed. The Bool indicates whether the request was (user-)canceled.
    var onWillDismiss: ((_ didCancel: Bool) -> Void)?
    
    /// Our web view.
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - View Handling
    override open func loadView() {
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        automaticallyAdjustsScrollViewInsets = true
        
        super.loadView()
        view.backgroundColor = UIColor.white
        
        // create a web view
        let web = WKWebView()
        
        web.translatesAutoresizingMaskIntoConstraints = false
 //       web.scrollView.decelerationRate = UIScrollView.decelerationRate.normal
        web.navigationDelegate = self
        view.addSubview(web)
        let views = ["web": web]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[web]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[web]|", options: [], metrics: nil, views: views))
        webView = web
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let web = webView {
            if nil != startURL {
                load(url: startURL!)
            }
            else {
                web.loadHTMLString("There is no `startURL`", baseURL: nil)
            }
        }
    }
    
    func showErrorMessage(_ message: String, animated: Bool) {
        NSLog("Error: \(message)")
    }
    
    
    // MARK: - Actions
    
    open func load(url: URL) {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 1)
        let _ = webView?.load(request)
    }
    
    
    // MARK: - Web View Delegate
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        if (navigationIsFinished) {
            let url = webView.url?.absoluteURL
            let nameHost = url?.host
            if nameHost == interceptURLString {
                let url = webView.url?.absoluteString
                let code = getQueryStringParameter(url: url!, param: "code")
                webView.stopLoading()
                decisionHandler(.allow)
                if code == nil || code == "" {
                    //Could throw error before this !
                    print("\nWe did not get authorization!!\n")
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.authorisation(success: false, token: nil)
                    return
                }
                requestToken(with: code)
                return
            }
        }
        decisionHandler(.allow)
    }

    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("\n\nStarting Provisional Navigation\n\n")
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("\n\nWebView didFinish\n\n")
        navigationIsFinished = true
    }
    
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if NSURLErrorDomain == error._domain && NSURLErrorCancelled == error._code {
            return
        }
        // do we still need to intercept "WebKitErrorDomain" error 102?
    }
}

extension AuthorizationViewController {
    func requestToken(with code: String?) {
        let grantType = "authorization_code"
        let clientID = "4141358e1df37fbee61b4859034d078b31376fa2996d354975bc9b086b60a073"
        let clientSecret = "896b82ef7831e9d4c316e3b570951af89aee3b0f36effc21168ecbb1450ab3c7"
        let redirectUri = "com.mmoullec.rush00://authorize"
        
        let scheme = "https"
        let host = "api.intra.42.fr"
        let path = "/oauth/token"
        
        let grantQuery = URLQueryItem(name: "grant_type", value: grantType)
        let clientQuery = URLQueryItem(name: "client_id", value: clientID)
        let secretQuery = URLQueryItem(name: "client_secret", value: clientSecret)
        let redirectQuery = URLQueryItem(name: "redirect_uri", value: redirectUri)
        let codeQuery = URLQueryItem(name: "code", value: code)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [grantQuery, clientQuery, secretQuery, redirectQuery, codeQuery]
        
        let url = urlComponents.url
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                // self.errorHandler(error: err as NSError)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        print(dic)
                        let apiAccessToken = dic.value(forKey: "access_token") as? String
                        if apiAccessToken != nil {
                            DispatchQueue.main.async {
                                //TODO: Stop loading the webview.
                                self.navigationController?.popViewController(animated: true)
                                self.delegate?.authorisation(success: true, token: apiAccessToken)
                            }
                        } else {
                            //TODO Show error no token
                        }
                    }
                }
                catch (let _) {
                    print("Error after getting response")
                    //                    self.errorHandler(error: err as NSError)
                }
            }
        })
        task.resume()
    }
}


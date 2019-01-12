//
//  OAuth2ViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//


import UIKit
import WebKit


/**
 A simple iOS web view controller that allows you to display the login/authorization screen.
 */
open class OAuth2WebViewController: UIViewController, WKNavigationDelegate {
    
    /// Handle to the OAuth2 instance in play, only used for debug lugging at this time.
//    var oauth: OAuth2?
    
    /// The URL to load on first show.
    open var startURL: URL? {
        didSet(oldURL) {
            if nil != startURL && nil == oldURL && isViewLoaded {
                load(url: startURL!)
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        startURL = URL(string:mmoullec42ApiCredentials.URL)
        //        let myURL = URL(string: "http://youtube.com")
        print(startURL!)
        interceptURLString = mmoullec42ApiCredentials.redirectURI
        
        // Do any additional setup after loading the view.
    }
    
    /// The URL string to intercept and respond to.
    var interceptURLString: String? {
        didSet(oldURL) {
            if let interceptURLString = interceptURLString {
                if let url = URL(string: interceptURLString) {
                    interceptComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
                }
                else {
                    print("failed to parse url \(interceptURLString)")
//                    oauth?.logger?.debug("OAuth2", msg: "Failed to parse URL \(interceptURLString), discarding")
                    self.interceptURLString = nil
                }
            }
            else {
                interceptComponents = nil
            }
            print("String", interceptURLString)
            print("Components", interceptComponents?.description)
        }
    }
    var interceptComponents: URLComponents?
    
    /// Closure called when the web view gets asked to load the redirect URL, specified in `interceptURLString`. Return a Bool indicating
    /// that you've intercepted the URL.
    var onIntercept: ((URL) -> Bool)?
    
    /// Called when the web view is about to be dismissed. The Bool indicates whether the request was (user-)canceled.
    var onWillDismiss: ((_ didCancel: Bool) -> Void)?
    
    /// Assign to override the back button, shown when it's possible to go back in history. Will adjust target/action accordingly.
    open var backButton: UIBarButtonItem? {
        didSet {
            if let backButton = backButton {
                backButton.target = self
                backButton.action = #selector(OAuth2WebViewController.goBack(_:))
            }
        }
    }
    
    var showCancelButton = true
    var cancelButton: UIBarButtonItem?
    
    /// Our web view.
    @IBOutlet weak var webView: WKWebView!
    
    
    /// An overlay view containing a spinner.
//    var loadingView: UIView?
    @IBOutlet var loadingView: UIView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - View Handling
    
    override open func loadView() {
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        automaticallyAdjustsScrollViewInsets = true
        
        super.loadView()
        view.backgroundColor = UIColor.white
        
        if showCancelButton {
            cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(OAuth2WebViewController.cancel(_:)))
            navigationItem.rightBarButtonItem = cancelButton
        }
        
        // create a web view
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        web.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        web.navigationDelegate = self
        
        view.addSubview(web)
        let views = ["web": web]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[web]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[web]|", options: [], metrics: nil, views: views))
        webView = web
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let web = webView, !web.canGoBack {
            if nil != startURL {
                load(url: startURL!)
            }
            else {
                web.loadHTMLString("There is no `startURL`", baseURL: nil)
            }
        }
    }
    
    func showHideBackButton(_ show: Bool) {
        if show {
            let bb = backButton ?? UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(OAuth2WebViewController.goBack(_:)))
            navigationItem.leftBarButtonItem = bb
        }
        else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    func showLoadingIndicator() {
        // TODO: implement
    }
    
    func hideLoadingIndicator() {
        // TODO: implement
    }
    
    func showErrorMessage(_ message: String, animated: Bool) {
        NSLog("Error: \(message)")
    }
    
    
    // MARK: - Actions
    
    open func load(url: URL) {
        let _ = webView?.load(URLRequest(url: url))
    }
    
    @objc func goBack(_ sender: AnyObject?) {
        let _ = webView?.goBack()
    }
    
    @objc func cancel(_ sender: AnyObject?) {
        dismiss(asCancel: true, animated: (nil != sender) ? true : false)
    }
    
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismiss(asCancel: false, animated: flag, completion: completion)
    }
    
    func dismiss(asCancel: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        webView?.stopLoading()
        
        if nil != self.onWillDismiss {
            self.onWillDismiss!(asCancel)
        }
        super.dismiss(animated: animated, completion: completion)
    }
    
    
    // MARK: - Web View Delegate
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        print("---->", navigationAction.request, "<---")
        guard let onIntercept = onIntercept else {
            decisionHandler(.allow)
            return
        }
        print("true")
        let request = navigationAction.request
        
        // we compare the scheme and host first, then check the path (if there is any). Not sure if a simple string comparison
        // would work as there may be URL parameters attached
        if let url = request.url, url.scheme == interceptComponents?.scheme && url.host == interceptComponents?.host {
            let haveComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            if let hp = haveComponents?.path, let ip = interceptComponents?.path, hp == ip || ("/" == hp + ip) {
                if onIntercept(url) {
                    decisionHandler(.cancel)
                }
                else {
                    decisionHandler(.allow)
                }
                return
            }
        }
        decisionHandler(.allow)
    }
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if "file" != webView.url?.scheme {
            showLoadingIndicator()
        }
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let scheme = interceptComponents?.scheme, "urn" == scheme {
            if let path = interceptComponents?.path, path.hasPrefix("ietf:wg:oauth:2.0:oob") {
                if let title = webView.title, title.hasPrefix("Success ") {
//                    oauth?.logger?.debug("OAuth2", msg: "Creating redirect URL from document.title")
                    let qry = title.replacingOccurrences(of: "Success ", with: "")
                    if let url = URL(string: "http://localhost/?\(qry)") {
                        _ = onIntercept?(url)
                        return
                    }
//                    oauth?.logger?.warn("OAuth2", msg: "Failed to create a URL with query parts \"\(qry)\"")
                }
            }
        }
        hideLoadingIndicator()
        showHideBackButton(webView.canGoBack)
    }
    
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if NSURLErrorDomain == error._domain && NSURLErrorCancelled == error._code {
            return
        }
        // do we still need to intercept "WebKitErrorDomain" error 102?
        
        if nil != loadingView {
            showErrorMessage(error.localizedDescription, animated: true)
        }
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
    private extension UIScrollView {
        enum DecelerationRate {
            static let normal = UIScrollViewDecelerationRateNormal
        }
    }
#endif


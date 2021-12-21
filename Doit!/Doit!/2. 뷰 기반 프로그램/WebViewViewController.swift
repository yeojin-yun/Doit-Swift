//
//  WebViewViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {

    
    let textField = UITextField()
    let goBtn = UIButton()
    let siteBtn1 = UIButton()
    let siteBtn2 = UIButton()
    let htmlBtn = UIButton()
    let fileBtn = UIButton()
    let webView = WKWebView()
    let toolBar = UIToolbar()
    let activityIndicator = UIActivityIndicatorView()
    
    //⭐️웹을 처음 시작할 때 보여줄 특정 웹페이지
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        webView.navigationDelegate = self
        loadWebPage("https://www.aifacta.co.kr")
    }
    
    //로딩 중일 때, activityIndicator 활성화
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    //로딩이 완료되었을 때, activityIndicator 숨김
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
    //로딩 실패 시, activityIndicator 숨김
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }

}
//MARK: -function
extension WebViewViewController {
    @objc func htmlBtnTapped(_ sender: UIButton) {
        let htmlString = "<h1> HTML Stirng </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://www.aifacta.co.kr\">아이파경영아카데미</a>로 이동</p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    
    }
    
    @objc func fileBtnTapped(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
    @objc func site1Tapped(_ sender: UIButton) {
        loadWebPage("https://www.aifacta.co.kr")
    }
    
    @objc func site2Tapped(_ sender: UIButton) {
        loadWebPage("https://www.aifacmc.co.kr")
    }
    
    @objc func stopBtnTapped(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        print(#function)
    }
    @objc func reloadBtnTapped(_ sender: UIBarButtonItem) {
        webView.reload()
        print(#function)
    }
    @objc func backBtnTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
        print(#function)
    }
    @objc func forwardBtnTapped(_ sender: UIBarButtonItem) {
        webView.goForward()
        print(#function)
    }
    
    func checkURL(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @objc func goBtnTapped(_ sender: UIButton) {
        let myUrl = checkURL(textField.text!)
        textField.text = ""
        loadWebPage(myUrl)
    }
}

//MARK: -UI
extension WebViewViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
        setToolBar()
    }
    final private func setToolBar() {
        var items: [UIBarButtonItem] = []
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let item1 = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopBtnTapped(_:)))
        let item2 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadBtnTapped(_:)))
        let item3 = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(backBtnTapped(_:)))
        let item4 = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(forwardBtnTapped(_:)))
        items.append(item1)
        items.append(flexibleItem)
        items.append(item2)
        items.append(flexibleItem)
        items.append(item3)
        items.append(flexibleItem)
        items.append(item4)
        
        toolBar.setItems(items, animated: true)
    }
    
    final private func setAttributes() {
        goBtn.setTitle("Go", for: .normal)
        goBtn.setTitleColor(.black, for: .normal)
        siteBtn1.setTitle("cta", for: .normal)
        siteBtn2.setTitle("cmc", for: .normal)
        htmlBtn.setTitle("html", for: .normal)
        fileBtn.setTitle("file", for: .normal)
        textField.borderStyle = .roundedRect
        
        [goBtn, siteBtn1, siteBtn2, htmlBtn, fileBtn].forEach {
            $0.setTitleColor(.black, for: .normal)
            
        }
        
        goBtn.addTarget(self, action: #selector(goBtnTapped(_:)), for: .touchUpInside)
        siteBtn1.addTarget(self, action: #selector(site1Tapped(_:)), for: .touchUpInside)
        siteBtn2.addTarget(self, action: #selector(site2Tapped(_:)), for: .touchUpInside)
        htmlBtn.addTarget(self, action: #selector(htmlBtnTapped(_:)), for: .touchUpInside)
        fileBtn.addTarget(self, action: #selector(fileBtnTapped(_:)), for: .touchUpInside)
        
    }
    final private func setConstraints() {
        let stack = UIStackView(arrangedSubviews: [siteBtn1, siteBtn2, htmlBtn, fileBtn])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        [textField, goBtn, stack, webView, toolBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            
            goBtn.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 30),
            goBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            webView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),

            toolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
    
}

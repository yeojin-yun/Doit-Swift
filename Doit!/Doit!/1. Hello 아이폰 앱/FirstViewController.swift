//
//  FirstViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class FirstViewController: UIViewController {

    let helloLbl = UILabel()
    let swiftLbl = UILabel()
    let nameLbl = UILabel()
    let textField = UITextField()
    let sendBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    @objc func sendBtnTapped(_ sender: UIButton) {
        helloLbl.text = textField.text
    }

}


//MARK: -UI
extension FirstViewController {
    final private func setUI() {
        setBasics()
        setLayout()
        
    }
    final private func setBasics() {
        helloLbl.text = "Hello"
        swiftLbl.text = "This is swift world"
        nameLbl.text = "name: "
        textField.borderStyle = .roundedRect
        sendBtn.setTitle("send", for: .normal)
        sendBtn.backgroundColor = .black
        sendBtn.setTitleColor(.white, for: .normal)
        sendBtn.addTarget(self, action: #selector(sendBtnTapped(_:)), for: .touchUpInside)
        
    }
    final private func setLayout() {
        [helloLbl, swiftLbl, nameLbl, textField, sendBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //⭐️텍스트필드와 버튼의 가운데 맞추는 방법 알아보기 (가로정렬)
        NSLayoutConstraint.activate([
            helloLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            helloLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            swiftLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            swiftLbl.topAnchor.constraint(equalTo: helloLbl.bottomAnchor, constant: 50),
            
            nameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            nameLbl.topAnchor.constraint(equalTo: swiftLbl.bottomAnchor, constant: 50),
            nameLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -270),
            
            textField.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor),
            textField.topAnchor.constraint(equalTo: swiftLbl.bottomAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            //textField.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            //textField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            sendBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            sendBtn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            //sendBtn.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
            
            
        ])
    }
}

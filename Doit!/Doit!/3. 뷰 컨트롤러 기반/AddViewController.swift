//
//  AddViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/31.
//

import UIKit

class AddViewController: UIViewController {

    let textField = UITextField()
    let sendBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        sendBtn.addTarget(self, action: #selector(sendBtnTapped(_:)), for: .touchUpInside)
    }
    
    @objc func sendBtnTapped(_ sender: UIButton) {
        items.append(textField.text!)
        images.append("clock.png")
        textField.text = ""
        navigationController?.popViewController(animated: true)
        
    }

    

}

//MARK: -UI
extension AddViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        sendBtn.setTitle("추가", for: .normal)
        sendBtn.setTitleColor(.black, for: .normal)
        textField.borderStyle = .roundedRect
    }
    
    final private func setConstraints() {
        [textField, sendBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            sendBtn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            //sendBtn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            sendBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

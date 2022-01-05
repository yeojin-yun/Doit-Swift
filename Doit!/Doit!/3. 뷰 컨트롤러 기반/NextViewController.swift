//
//  NextViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/28.
//

import UIKit

protocol EditDelegate {
    //func didMessageEditDone(_ controller: NextViewController, message: String)
    func didMessageEditDone(message: String)
    //func didImgaeOnOffDone(_ controller: NextViewController, isOn: Bool)
    func didImgaeOnOffDone(isOn: Bool)
}


class NextViewController: UIViewController {

    
    let mainLbl = UILabel()
    let completeBtn = UIButton()
    let messageLbl = UILabel()
    let textField = UITextField()
    let onLbl = UILabel()
    let switchOn = UISwitch()
    
    
    var textValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
        
    var EditIsOn = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        textField.text = textMessage
        
    }
    
}

//MARK: -Event
extension NextViewController {

    @objc func completeBtnTapped(_ sender: UIButton) {
        let text = textField.text ?? ""
        delegate?.didMessageEditDone(message: text)
        delegate?.didImgaeOnOffDone(isOn: EditIsOn)
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            EditIsOn = true
        } else {
            EditIsOn = false
        }
    }
}




//MARK: -UI
extension NextViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    final private func setAttributes() {
        completeBtn.setTitle("완료", for: .normal)
        completeBtn.setTitleColor(.black, for: .normal)
        messageLbl.text = "Message"
        textField.borderStyle = .roundedRect
        onLbl.text = "전구 켜기"
        switchOn.isOn = EditIsOn
        
        
        completeBtn.addTarget(self, action: #selector(completeBtnTapped(_:)), for: .touchUpInside)
        switchOn.addTarget(self, action: #selector(switchTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        [mainLbl, completeBtn, messageLbl, textField, onLbl, switchOn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            completeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            completeBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            messageLbl.topAnchor.constraint(equalTo: completeBtn.bottomAnchor, constant: 30),
            messageLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textField.topAnchor.constraint(equalTo: messageLbl.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            onLbl.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            onLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            
            switchOn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            switchOn.leadingAnchor.constraint(equalTo: onLbl.trailingAnchor, constant: 20)
            
        ])
    }
}

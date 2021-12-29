//
//  NextViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/28.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: NextViewController, message: String)
}

//protocol TextSendDelegate: class {
//    func sendText(text: String)
//}

class NextViewController: UIViewController {

    
    let mainLbl = UILabel()
    let completeBtn = UIButton()
    let messageLbl = UILabel()
    let textField = UITextField()
    
    var textValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    //var delegate: TextSendDelegate?
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        //textField.text = text
        //NextViewController.delegate = self
    }
    
}

//MARK: -Event
extension NextViewController {

    @objc func completeBtnTapped(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: textField.text!)
        }
        
        
        self.navigationController?.popViewController(animated: true)
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
        completeBtn.addTarget(self, action: #selector(completeBtnTapped(_:)), for: .touchUpInside)
        messageLbl.text = "Message"
        textField.borderStyle = .bezel
    }
    
    final private func setConstraints() {
        [mainLbl, completeBtn, messageLbl, textField].forEach {
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
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

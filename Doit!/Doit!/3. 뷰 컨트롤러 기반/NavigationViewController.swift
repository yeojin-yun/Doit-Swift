//
//  NavigationViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit


class NavigationViewController: UIViewController, EditDelegate {


    

    //let mainLbl = UILabel()
    let editBtn = UIButton()
    let messageLbl = UILabel()
    let textField = UITextField()
    //let imgView = UIImageView()
    
    var textMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
//        let next = NextViewController()
//        next.delegate = self
//        next.textMessage = textField.text!
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(rightBtnTapped(_:)))
        
    }

    func didMessageEditDone(_ controller: NextViewController, message: String) {
        textField.text = message
        let next = NextViewController()
        next.delegate = self
        next.textMessage = textField.text!
    }
    
//    func sendText(text: String) {
//        textField.text = text
//    }
    
}


//MARK: -Event
extension NavigationViewController {
    @objc func rightBtnTapped (_ sender: UIButton) {
        let nextVC = NextViewController()
        nextVC.navigationItem.title = "수정화면"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func editBtnTapped(_ sender: UIButton) {
        let nextVC = NextViewController()
        nextVC.navigationItem.title = "수정화면"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}



//MARK: -UI
extension NavigationViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    final private func setAttributes() {
        editBtn.setTitle("수정", for: .normal)
        editBtn.setTitleColor(.black, for: .normal)
        editBtn.addTarget(self, action: #selector(editBtnTapped(_:)), for: .touchUpInside)
        messageLbl.text = "Message"
        textField.borderStyle = .roundedRect
        textField.text = textMessage
    }
    
    final private func setConstraints() {
        [editBtn, messageLbl, textField].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([

            editBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            editBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            messageLbl.topAnchor.constraint(equalTo: editBtn.bottomAnchor, constant: 30),
            messageLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            textField.topAnchor.constraint(equalTo: messageLbl.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

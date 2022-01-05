//
//  NavigationViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit


class NavigationViewController: UIViewController, EditDelegate {

    

    let editBtn = UIButton()
    let messageLbl = UILabel()
    let textField = UITextField()
    let imgView = UIImageView()
    
    var textMessage: String = ""
    
    let imgOn = UIImage(named: "lamp_on")
    let imgOff = UIImage(named: "lamp_off")
    var originalIsOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(rightBtnTapped(_:)))
    }

    func didMessageEditDone(message: String) {
        textField.text = message
    }

    func didImgaeOnOffDone(isOn: Bool) {

        if isOn {
            imgView.image = imgOn
            self.originalIsOn = true
        } else {
            imgView.image = imgOff
            self.originalIsOn = false
        }
    }
}


//MARK: -Event
extension NavigationViewController {
    @objc func rightBtnTapped (_ sender: UIButton) {
        let nextVC = NextViewController()
        nextVC.delegate = self
        nextVC.textMessage = textField.text!
        nextVC.EditIsOn = originalIsOn
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        
    }
    
    @objc func editBtnTapped(_ sender: UIButton) {
        let nextVC = NextViewController()
        nextVC.delegate = self
        nextVC.textMessage = textField.text!
        nextVC.EditIsOn = originalIsOn
        self.navigationController?.pushViewController(nextVC, animated: true)
        //nextVC.modalPresentationStyle = .fullScreen
        
        //present(nextVC, animated: true, completion: nil)
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
        imgView.image = imgOn
        imgView.contentMode = .scaleAspectFit
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = CGColor.init(red: 0.0 / 255.0, green: 201.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)

        
    }
    
    final private func setConstraints() {
        [editBtn, messageLbl, textField, imgView].forEach {
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
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            imgView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),

        ])
    }
}

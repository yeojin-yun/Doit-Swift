//
//  VideoViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class VideoViewController: UIViewController {

    let firstLbl = UILabel()
    let firstBtn = UIButton()
    let secondLbl = UILabel()
    let secondBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = UIColor(red: 240.0 / 255.0, green: 237.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    

}


//MARK: -UI
extension VideoViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        firstLbl.text = "첫 번째 동영상"
        secondLbl.text = "두 번째 동영상"
        firstBtn.backgroundColor = UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
        secondBtn.backgroundColor = UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
        
        [firstLbl, secondLbl].forEach {
            $0.layer.cornerRadius = 40
            $0.textColor = UIColor(red: 240.0 / 255.0, green: 237.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
            $0.backgroundColor = UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
        }
    }
    final private func setConstraints() {
        [firstLbl, secondLbl, firstBtn, secondBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            firstLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            firstLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            firstLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            firstLbl.heightAnchor.constraint(equalToConstant: 50),
            
            
            firstBtn.topAnchor.constraint(equalTo: firstLbl.bottomAnchor, constant: 10),
            firstBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            firstBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            firstBtn.heightAnchor.constraint(equalToConstant: 200),
            
            
            secondLbl.topAnchor.constraint(equalTo: firstBtn.bottomAnchor, constant: 30),
            secondLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            secondLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            secondLbl.heightAnchor.constraint(equalTo: firstLbl.heightAnchor),
            
            
            secondBtn.topAnchor.constraint(equalTo: secondLbl.bottomAnchor, constant: 10),
            secondBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            secondBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            secondBtn.heightAnchor.constraint(equalTo: firstBtn.heightAnchor),
            
        ])
    }
}

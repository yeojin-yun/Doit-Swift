//
//  DetailViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    let mainLbl = UILabel()
    var thingsToDo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    
    



}

//MARK: -UI
extension DetailViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        mainLbl.text = thingsToDo
    }
    final private func setConstraints() {
        [mainLbl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            mainLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            mainLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
//            mainLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
}

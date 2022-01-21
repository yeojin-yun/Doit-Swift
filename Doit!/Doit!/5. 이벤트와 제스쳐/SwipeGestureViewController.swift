//
//  SwipeGestureViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class SwipeGestureViewController: UIViewController {

    let leftImg = UIImageView()
    let topImg = UIImageView()
    let rightImg = UIImageView()
    let bottomImg = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        // Do any additional setup after loading the view.
    }
    

}

//MARK: -UI
extension SwipeGestureViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        leftImg.image = UIImage(systemName: "arrow.left.square")
        rightImg.image = UIImage(systemName: "arrow.right.square")
        topImg.image = UIImage(systemName: "arrow.up.square")
        bottomImg.image = UIImage(systemName: "arrow.down.square")
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        let verticalStack = UIStackView(arrangedSubviews: [topImg, bottomImg])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 100
        
        let horizontalStack = UIStackView(arrangedSubviews: [leftImg, rightImg])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 100
        
        [verticalStack, horizontalStack, leftImg].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
//            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            leftImg.heightAnchor.constraint(equalToConstant: 300),
            leftImg.widthAnchor.constraint(equalToConstant: 300),
            verticalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            horizontalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
//            horizontalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            horizontalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            horizontalStack.heightAnchor.constraint(equalToConstant: 300),
            horizontalStack.widthAnchor.constraint(equalToConstant: 300),
            horizontalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

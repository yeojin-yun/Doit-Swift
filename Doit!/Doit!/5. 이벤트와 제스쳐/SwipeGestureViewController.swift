//
//  SwipeGestureViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class SwipeGestureViewController: UIViewController {

    let leftImg = UIView()
    let topImg = UIView()
    let rightImg = UIView()
    let bottomImg = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        let verticalStack = UIStackView(arrangedSubviews: [topImg, bottomImg])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        
        let horizontalStack = UIStackView(arrangedSubviews: [leftImg, rightImg])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        
//        [<#UILabel#>, <#UIButton#>].forEach {
//            view.addSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
    }
}

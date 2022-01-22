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
    
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    var imgTop = [UIImage]()
    var imgBottom = [UIImage]()
    
    
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
        addArray()
    }
    func addArray() {
        imgLeft.append(UIImage(systemName: "arrow.left.square")!)
        imgLeft.append(UIImage(systemName: "arrow.left.square.fill")!)
        imgRight.append(UIImage(systemName: "arrow.right.square")!)
        imgRight.append(UIImage(systemName: "arrow.right.square.fill")!)
        imgTop.append(UIImage(systemName: "arrow.up.square")!)
        imgTop.append(UIImage(systemName: "arrow.up.square.fill")!)
        imgBottom.append(UIImage(systemName: "arrow.down.square")!)
        imgBottom.append(UIImage(systemName: "arrow.down.square.fill")!)
        
    }
    
    final private func setAttributes() {
        leftImg.image = imgLeft[0]
        rightImg.image = imgRight[0]
        topImg.image = imgTop[0]
        bottomImg.image = imgBottom[0]
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
        
        [verticalStack, horizontalStack].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            verticalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            leftImg.heightAnchor.constraint(equalToConstant: 100),
            leftImg.widthAnchor.constraint(equalToConstant: 100),
            rightImg.heightAnchor.constraint(equalTo: leftImg.heightAnchor),
            rightImg.widthAnchor.constraint(equalTo: leftImg.widthAnchor),

            horizontalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            horizontalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topImg.heightAnchor.constraint(equalToConstant: 100),
            topImg.widthAnchor.constraint(equalToConstant: 100),
            bottomImg.heightAnchor.constraint(equalTo: topImg.heightAnchor),
            bottomImg.widthAnchor.constraint(equalTo: topImg.widthAnchor)
        ])
    }
}

//
//  SwipeGestureViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class SwipeGestureViewController: UIViewController {

    let leftImg = UIImageView()
    let upImg = UIImageView()
    let rightImg = UIImageView()
    let downImg = UIImageView()
    
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    var imgUp = [UIImage]()
    var imgDown = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setUpGesture()
        print(imgLeft[0])
    }
}

//MARK: -Swipe Gesture
extension SwipeGestureViewController{
    func setUpGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SwipeGestureViewController.respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(SwipeGestureViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SwipeGestureViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SwipeGestureViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            leftImg.image = imgLeft[0]
            rightImg.image = imgRight[0]
            upImg.image = imgUp[0]
            downImg.image = imgDown[0]
            
            switch swipeGesture.direction {
            case .up:
                upImg.image = imgUp[1]
            case .down:
                downImg.image = imgDown[1]
            case .left:
                leftImg.image = imgLeft[1]
            case .right:
                rightImg.image = imgRight[1]
            default:
                break
            }
        }
    }
}

//MARK: -UI
extension SwipeGestureViewController {
    final private func configureUI() {
        addArray()
        setAttributes()
        addTarget()
        setConstraints()
    }
    func addArray() {
        imgLeft.append(UIImage(systemName: "arrow.left.square")!)
        imgLeft.append(UIImage(systemName: "arrow.left.square.fill")!)
        imgRight.append(UIImage(systemName: "arrow.right.square")!)
        imgRight.append(UIImage(systemName: "arrow.right.square.fill")!)
        imgUp.append(UIImage(systemName: "arrow.up.square")!)
        imgUp.append(UIImage(systemName: "arrow.up.square.fill")!)
        imgDown.append(UIImage(systemName: "arrow.down.square")!)
        imgDown.append(UIImage(systemName: "arrow.down.square.fill")!)
        
    }
    
    final private func setAttributes() {
        leftImg.image = imgLeft[0]
        rightImg.image = imgRight[0]
        upImg.image = imgUp[0]
        downImg.image = imgDown[0]
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        let verticalStack = UIStackView(arrangedSubviews: [upImg, downImg])
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
            upImg.heightAnchor.constraint(equalToConstant: 100),
            upImg.widthAnchor.constraint(equalToConstant: 100),
            downImg.heightAnchor.constraint(equalTo: upImg.heightAnchor),
            downImg.widthAnchor.constraint(equalTo: upImg.widthAnchor)
        ])
    }
}

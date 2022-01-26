//
//  MissionPageControlViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/22.
//

import UIKit

class MissionPageControlViewController: UIViewController {

    let myView = UIView()
    let label = UILabel()
    var initialFontSize: CGFloat!
    let pageControl = UIPageControl()
    let colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.brown, UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setUpSwipe()
        setUpPinch()
    }
}

//MARK: -PinceGesture

extension MissionPageControlViewController{
    func setUpPinch() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(respondPinchGesture(_:)))
        view.addGestureRecognizer(pinch)
    }
    
    @objc func respondPinchGesture(_ pinch: UIPinchGestureRecognizer) {
        if pinch.state == UIPinchGestureRecognizer.State.began {
            initialFontSize = label.font.pointSize
        } else {
            // pinch제스쳐의 상태가 "시작"이 아니라면, 핀치제스쳐가 계속 진행되고 있는 상태이므로, initialFontSize에 저장해 둔 글자 크기 값에 scale 속성을 곱하여 텍스트의 글자 크기에 반영
            label.font = label.font.withSize(initialFontSize * pinch.scale)
        }
    }
    
}
//MARK: -SwipeGesture
extension MissionPageControlViewController {
    func setUpSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func respondSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .left:
                if pageControl.currentPage < pageControl.numberOfPages {
                    pageControl.currentPage = pageControl.currentPage + 1
                }
            case .right:
                if pageControl.currentPage > 0 {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
            default:
                break
            }
            myView.backgroundColor = colors[pageControl.currentPage]
        }
    }
}


//MARK: -Event
extension MissionPageControlViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        myView.backgroundColor = colors[pageControl.currentPage]
        
        label.text = String(pageControl.currentPage + 1)
        if myView.backgroundColor == UIColor.yellow {
            label.textColor = .black
        } else {
            label.textColor = .white
        }
    }
}

//MARK: -UI
extension MissionPageControlViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        pageControl.numberOfPages = colors.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        myView.backgroundColor = colors[0]
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    final private func setConstraints() {
        [myView, label, pageControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
}

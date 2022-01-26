//
//  PageControlViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class PageControlViewController: UIViewController {

    let pageControl = UIPageControl()
    let imgView = UIImageView()
    let images = ["뭉치1", "뭉치2", "뭉치3", "뭉치4"]
    //var numberOfPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setUpSwipe()
        setUpPinch()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "미션", style: .plain, target: self, action: #selector(rightBarBtnTapped(_:)))
    }
}
//MARK: -Event
extension PageControlViewController {
    @objc func pageControllerTapped(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
        
        
    }
    
    @objc func rightBarBtnTapped(_ sender: UIBarButtonItem) {
        let nextVC = MissionPageControlViewController()
        nextVC.navigationItem.title = "PageControl Mission"
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
// MARK: SwipeGesture
extension PageControlViewController {
    func setUpSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func respondToSwipe(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                if (pageControl.currentPage > 0) {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
                print("right")
            case .left:
                if (pageControl.currentPage<pageControl.numberOfPages - 1) {
                    pageControl.currentPage = pageControl.currentPage + 1
                }
                print("left")
            default:
                break
                
            }
            imgView.image = UIImage(named: images[pageControl.currentPage])
        }
    }
}

//MARK: -PinchGesture
extension PageControlViewController {
    func setUpPinch() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(respondToPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    @objc func respondToPinch(_ pinch: UIPinchGestureRecognizer) {
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
}


//MARK: -UI
extension PageControlViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
//        imgVeiw.image = UIImage(named: "뭉치1")
        imgView.contentMode = .scaleAspectFill
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        imgView.image = UIImage(named: images[0])
        
        pageControl.addTarget(self, action: #selector(pageControllerTapped(_:)), for: .valueChanged)
    }
    final private func setConstraints() {
        [pageControl, imgView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pageControl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

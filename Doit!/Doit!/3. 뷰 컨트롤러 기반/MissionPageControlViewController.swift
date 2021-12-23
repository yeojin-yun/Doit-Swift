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
    let pageControl = UIPageControl()
    let colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.brown, UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
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

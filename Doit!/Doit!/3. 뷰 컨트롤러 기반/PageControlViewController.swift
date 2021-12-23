//
//  PageControlViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class PageControlViewController: UIViewController {

    let pageControl = UIPageControl()
    let imgVeiw = UIImageView()
    let images = ["뭉치1", "뭉치2", "뭉치3", "뭉치4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "미션", style: .plain, target: self, action: #selector(rightBarBtnTapped(_:)))
    }
    

    
}
//MARK: -Event
extension PageControlViewController {
    @objc func pageControllerTapped(_ sender: UIPageControl) {
        imgVeiw.image = UIImage(named: images[pageControl.currentPage])
    }
    
    @objc func rightBarBtnTapped(_ sender: UIBarButtonItem) {
        let nextVC = MissionPageControlViewController()
        nextVC.navigationItem.title = "PageControl Mission"
        navigationController?.pushViewController(nextVC, animated: true)
        
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
        imgVeiw.contentMode = .scaleAspectFill
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        imgVeiw.image = UIImage(named: images[0])
        
        pageControl.addTarget(self, action: #selector(pageControllerTapped(_:)), for: .valueChanged)
    }
    final private func setConstraints() {
        [pageControl, imgVeiw].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imgVeiw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imgVeiw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imgVeiw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imgVeiw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pageControl.topAnchor.constraint(equalTo: imgVeiw.bottomAnchor, constant: 10),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

//
//  CameraViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class CameraViewController: UIViewController {

    let imageView = UIImageView()
    let takePhotoBtn = UIButton()
    let downPhotoBtn = UIButton()
    let takeVideoBtn = UIButton()
    let downVideoBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    



}

//MARK: -UI
extension CameraViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        imageView.backgroundColor = .red
        takePhotoBtn.setTitle("사진 촬영", for: .normal)
        takeVideoBtn.setTitle("동영상 촬영", for: .normal)
        downPhotoBtn.setTitle("사진 불러오기", for: .normal)
        downVideoBtn.setTitle("동영상 불러오기", for: .normal)
        
        [takePhotoBtn, takeVideoBtn, downVideoBtn, downPhotoBtn].forEach {
            $0.setTitleColor(.red, for: .normal)
        }
        
    }
    final private func setConstraints() {
        let stack1 = UIStackView(arrangedSubviews: [takePhotoBtn, takeVideoBtn])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        
        let stack2 = UIStackView(arrangedSubviews: [downPhotoBtn, downVideoBtn])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        
        [imageView, stack1, stack2].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            stack1.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant: 15),
            stack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stack2.topAnchor.constraint(equalTo:stack1.bottomAnchor, constant: 20),
            stack2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

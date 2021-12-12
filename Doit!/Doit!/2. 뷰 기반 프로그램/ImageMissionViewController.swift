//
//  ImageMissionViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class ImageMissionViewController: UIViewController {

    let mainLbl = UILabel()
    let imgView = UIImageView()
    let preBtn = UIButton()
    let nextBtn = UIButton()

    var num = 1
    var imgName: String = ""


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    

}

//MARK: -UI
extension ImageMissionViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    
    final private func setBasics() {
        
        mainLbl.text = "Image Viewer"
        preBtn.setTitle("이전", for: .normal)
        preBtn.setTitleColor(.black, for: .normal)
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.black, for: .normal)
        imgName = String(num)
        imgView.image = UIImage(named: "1")
        

        
        
        preBtn.addTarget(self, action: #selector(preBtnTapped(_:)), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextBtnTapped(_:)), for: .touchUpInside)
        
    }
    
    final private func setLayout() {
        [mainLbl, imgView, preBtn, nextBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imgView.topAnchor.constraint(equalTo: mainLbl.bottomAnchor, constant: 50),
            imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            preBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            preBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            nextBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            
        ])
    }
    
    @objc func preBtnTapped(_ sender: UIButton) {
        
        if num > 1 {
            num = num - 1
            imgName = String(num)
            imgView.image = UIImage(named: imgName)
            print(num)
        }
        
        
        
        
    }
    
    
    @objc func nextBtnTapped(_ sender: UIButton) {
        
        if num < 6 {
            num = num + 1
            imgName = String(num)
            imgView.image = UIImage(named: imgName)
            print(num)
        } else if num >= 6 {
            num = 1
            imgName = String(num)
            imgView.image = UIImage(named: imgName)
            print("문제: \(num)")
            
        }
        
    }
    
}

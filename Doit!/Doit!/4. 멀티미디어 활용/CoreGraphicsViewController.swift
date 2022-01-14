//
//  CoreGraphicsViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class CoreGraphicsViewController: UIViewController {

    let imgView = UIImageView()
    let drawBtn = UIButton()
    let rectangleBtn = UIButton()
    let circleBtn = UIButton()
    let fillBtn = UIButton()
    let arcBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240.0 / 255.0, green: 237.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
        configureUI()
    }
    


}
//MARK: -Event
extension CoreGraphicsViewController {
    @objc func drawBtnTapped(_ sender: UIButton) {
        
    }
    @objc func rectangleBtnTapped(_ sender: UIButton) {
        
    }
    @objc func circleBtnTapped(_ sender: UIButton) {
        
    }
    @objc func arcBtnTapped(_ sender: UIButton) {
        
    }
    @objc func fillBtnTapped(_ sender: UIButton) {
        
    }
}

//MARK: -UI
extension CoreGraphicsViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        imgView.backgroundColor = UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
        drawBtn.setTitle("선", for: .normal)
        rectangleBtn.setTitle("사각형", for: .normal)
        circleBtn.setTitle("원", for: .normal)
        arcBtn.setTitle("호", for: .normal)
        fillBtn.setTitle("채우기", for: .normal)
        
        [drawBtn, rectangleBtn, circleBtn, arcBtn, fillBtn].forEach {
            $0.setTitleColor(UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0), for: .normal)
        }
    }
    final private func addTarget() {
        drawBtn.addTarget(self, action: #selector(drawBtnTapped(_:)), for: .touchUpInside)
        rectangleBtn.addTarget(self, action: #selector(rectangleBtnTapped(_:)), for: .touchUpInside)
        circleBtn.addTarget(self, action: #selector(circleBtnTapped(_:)), for: .touchUpInside)
        arcBtn.addTarget(self, action: #selector(arcBtnTapped(_:)), for: .touchUpInside)
        fillBtn.addTarget(self, action: #selector(fillBtnTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [drawBtn, rectangleBtn, circleBtn, arcBtn, fillBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        [imgView, stackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            imgView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
            
        ])
    }
}


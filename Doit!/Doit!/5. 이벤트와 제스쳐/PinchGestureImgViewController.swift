//
//  PinchGestureImgViewController.swift
//  Doit!
//
//  Created by 순진이 on 2022/01/26.
//

import UIKit

class PinchGestureImgViewController: UIViewController {

    
    let pinchImg = UIImageView()
    
    // 글자 크기를 저장하기 위한 변수
    var initialFontSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setUPGesture()
    }
    

}



extension PinchGestureImgViewController {
    func setUPGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(doPinch(_:)))
        // 핀치 제스쳐 등록
        self.view.addGestureRecognizer(pinch)
    }
    
    // 핀치 제스처 액션
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // pinchImg를 scale에 맞게 변환
        pinchImg.transform = pinchImg.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        // 다음 변환을 위해 핀치의 스케일 속성을 1로 설정
        pinch.scale = 1
    }
}

//MARK: -UI
extension PinchGestureImgViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        pinchImg.image = UIImage(named: "뭉치1")
    }
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        [pinchImg].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pinchImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pinchImg.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}


//
//  PinchGestureViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class PinchGestureViewController: UIViewController {

    let pinchLabel = UILabel()
    
    var initialFontSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setUPGesture()
    }
    


}

extension PinchGestureViewController {
    func setUPGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // pince 제스처의 상태 확인
        if (pinch.state == UIGestureRecognizer.State.began) {
            // pinch제스쳐의 상태가 "시작"이면 앞에서 선언한 initialFontSize 변수에 현재 텍스트의 글자 크기 저장
            initialFontSize = pinchLabel.font.pointSize
        } else {
            // pinch제스쳐의 상태가 "시작" 아니라면, 핀치제스쳐가 계속 진행되고 있는 상태이므로, initialFontSize에 저장해 둔 글자 크기 값에 scale 속성을 곱하여 텍스트의 글자 크기에 반영
            pinchLabel.font = pinchLabel.font.withSize(initialFontSize * pinch.scale)
        }
    }
}

//MARK: -UI
extension PinchGestureViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        pinchLabel.text = "Pinch"
        pinchLabel.textColor = .darkGray
    }
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        [pinchLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pinchLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pinchLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}


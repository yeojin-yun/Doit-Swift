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
        if (pinch.state == UIGestureRecognizer.State.began) {
            initialFontSize = pinchLabel.font.pointSize
        } else {
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


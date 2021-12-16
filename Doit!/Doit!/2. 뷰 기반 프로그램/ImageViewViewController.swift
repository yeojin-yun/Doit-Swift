//
//  ImageViewViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class ImageViewViewController: UIViewController {

    let imageView = UIImageView()
    let btn = UIButton()
    let mySwitch = UISwitch()
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "미션", style: .plain, target: self, action: #selector(rightBarButton(_:)))
        setUI()
    }
}

//MARK: -UI
extension ImageViewViewController {
    
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        imgOn = UIImage(named: "lamp_on")
        imgOff = UIImage(named: "lamp_off")
        imageView.image = imgOn
        imageView.frame = CGRect(x: 50, y: 100, width: 150, height: 200)
        imageView.contentMode = .scaleAspectFit
        mySwitch.isOn = true
        btn.setTitle("확대", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        mySwitch.addTarget(self, action: #selector(switchOn(_:)), for: .valueChanged)
    }
    final private func setLayout() {
        [btn, mySwitch].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            //imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            //imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            mySwitch.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 160),
            mySwitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
        
    }
    
    @objc func btnTapped(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newHeight: CGFloat, newWidth: CGFloat
        if isZoom {
            newHeight = imageView.frame.height / scale
            newWidth = imageView.frame.width / scale
            btn.setTitle("확대", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .black
        } else {
            newHeight = imageView.frame.height * scale
            newWidth = imageView.frame.width * scale
            btn.setTitle("축소", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .black
        }
        imageView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    @objc func switchOn(_ sender: UISwitch) {
        if sender.isOn {
            imageView.image = imgOn
        } else {
            imageView.image = imgOff
        }
    }
    
    @objc func rightBarButton(_ sender: UIButton) {
        let nextVC = ImageMissionViewController()
        nextVC.navigationItem.title = "ImageView Mission"
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

//
//  TabBarViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class TabBarViewController: UIViewController {

    let leftBtn = UIButton()
    let rightBtn = UIButton()
    let colorView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    
    @objc func btnTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "ImageView":
            tabBarController?.selectedIndex = 1
            //let nextVC = ImageViewViewController()
            //self.navigationController?.pushViewController(nextVC, animated: true)
        case "DatePicker":
            tabBarController?.selectedIndex = 2
            //let nextVC = DatePickerViewController()
            //self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            break
        }
    }
}

//MARK: -UI
extension TabBarViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        leftBtn.setTitle("ImageView", for: .normal)
        leftBtn.setTitleColor(.black, for: .normal)
        leftBtn.backgroundColor = UIColor(red: 175.0 / 255.0, green: 156.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
        leftBtn.layer.cornerRadius = 10
        
        rightBtn.setTitle("DatePicker", for: .normal)
        rightBtn.setTitleColor(.black, for: .normal)
        rightBtn.backgroundColor = UIColor(red: 0.0 / 255.0, green: 201.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
        rightBtn.layer.cornerRadius = 10
        
        colorView.backgroundColor = UIColor(red: 255.0 / 255.0, green: 128.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    final private func setConstraints() {
        view.addSubview(colorView)
        [leftBtn, rightBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        }
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            leftBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            rightBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            rightBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            colorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            colorView.widthAnchor.constraint(equalTo: leftBtn.widthAnchor),
            colorView.heightAnchor.constraint(equalTo: leftBtn.widthAnchor)
        ])
    }
}


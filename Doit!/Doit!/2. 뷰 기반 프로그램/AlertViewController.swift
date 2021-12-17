//
//  AlertViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class AlertViewController: UIViewController {
    
    let imageView = UIImageView()
    let onBtn = UIButton()
    let offBtn = UIButton()
    let removeBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBtnTapped(_:)))
    }
    

    
}

//MARK: -UI
extension AlertViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
        adddTarget()
    }
    final private func setAttributes() {
        onBtn.setTitle("켜기", for: .normal)
        offBtn.setTitle("끄기", for: .normal)
        removeBtn.setTitle("제거", for: .normal)
        [onBtn, offBtn, removeBtn].forEach {
            $0.backgroundColor = .black
            $0.titleLabel?.textColor = .white
            $0.layer.cornerRadius = 20
        }
        imageView.image = UIImage(named: "lamp_on")
    }
    
    
    final private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [onBtn, offBtn, removeBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        
        [stackView, imageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
    
    final private func adddTarget() {
        onBtn.addTarget(self, action: #selector(onBtnTapped(_:)), for: .touchUpInside)
        offBtn.addTarget(self, action: #selector(offBtnTapped(_:)), for: .touchUpInside)
        removeBtn.addTarget(self, action: #selector(removeBtnTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc func onBtnTapped (_ sender: UIButton) {
        //전구가 켜져있으면, 경고 Alert실행
        switch self.imageView.image {
        case UIImage(named: "lamp_on"):
            let alert = UIAlertController(title: "경고 🤬", message: "현재 켜져있습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "알겠습니다.", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        case UIImage(named: "lamp_off"):
            imageView.image = UIImage(named: "lamp_on")
        default:
            break
        }
        
    }
    
    
    @objc func offBtnTapped (_ sender: UIButton) {
        let alert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네", style: .default) { _ in
            self.imageView.image = UIImage(named: "lamp_off")
        }
        let cancleAction = UIAlertAction(title: "아니오", style: .cancel) { _ in
            self.imageView.image = UIImage(named: "lamp_on")
        }
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func removeBtnTapped (_ sender: UIButton) {
        let alert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: .actionSheet)
        let offAction = UIAlertAction(title: "아니오. 끕니다(off)", style: .default) { _ in
            if self.imageView.image == UIImage(named: "lamp_on") {
                self.imageView.image = UIImage(named: "lamp_off")
            }
        }
        
        let onAction = UIAlertAction(title: "예. 켭니다(on)", style: .default) { _ in
            if self.imageView.image == UIImage(named: "lamp_off") {
                self.imageView.image = UIImage(named: "lamp_on")
            }
        }
        
        let removeAction = UIAlertAction(title: "네. 제거합니다", style: .default) { _ in
            self.imageView.image = UIImage(named: "lamp-remove")
        }
        

        
        alert.addAction(offAction)
        alert.addAction(onAction)
        alert.addAction(removeAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func rightBtnTapped(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(DatePickerViewController(), animated: true)
        
    }
}

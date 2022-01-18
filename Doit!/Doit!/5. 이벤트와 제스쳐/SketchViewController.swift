//
//  SketchViewController.swift
//  Doit!
//
//  Created by 순진이 on 2022/01/17.
//

import UIKit

class SketchViewController: UIViewController {

    let imageView = UIImageView()
    let clearBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    

}

//MARK: -UI
extension SketchViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        imageView.backgroundColor = .green
        clearBtn.setTitle("Clear", for: .normal)
        clearBtn.setTitleColor(.red, for: .normal)
    }
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        [imageView, clearBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            clearBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            clearBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            clearBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            clearBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

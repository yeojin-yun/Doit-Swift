//
//  PickerViewViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class PickerViewViewController: UIViewController {

    let pickView = UIPickerView()
    let mainLbl = UILabel()
    let titleLbl = UILabel()
    let selectedImgView = UIImageView()
    //let imgArray: [UIImage] = []
    
    
    let img = ["PickerView1", "PickerView2", "PickerView3", "PickerView4", "PickerView5", "PickerView6", "PickerView7", "PickerView8", "PickerView9", "PickerView10"]
    
    var images: [UIImage] = {
        return (1...10).compactMap { UIImage(named: "PickerView\($0)") }
    }()
    
//    var images: [String] = {
//        return (1...10).compactMap { "PickerView\($0)" }
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    
}

//MARK: -UI
extension PickerViewViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    
    final private func setAttributes() {
        pickView.delegate = self
        pickView.dataSource = self
        mainLbl.text = "Selectd Item"
        mainLbl.backgroundColor = .black
        mainLbl.layer.cornerRadius = 20
        mainLbl.textColor = .white
        titleLbl.text = "PickerView1"
        selectedImgView.image = UIImage(named: "PickerView1")
        
    }
    
    
    final private func setConstraints() {
        [mainLbl, titleLbl, pickView, selectedImgView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pickView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pickView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            mainLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainLbl.topAnchor.constraint(equalTo: pickView.bottomAnchor, constant: 30),
            
            titleLbl.leadingAnchor.constraint(equalTo: mainLbl.trailingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: pickView.bottomAnchor, constant: 30),
            
            selectedImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            selectedImgView.topAnchor.constraint(equalTo: mainLbl.topAnchor, constant: 50),
            selectedImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            selectedImgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
}

extension PickerViewViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //피커뷰에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //피커 뷰에게 컴포넌트의 열의 개수를 정수 값으로 넘겨주는 델리게이트 메서드
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    //피커 뷰에게 컴포넌트의 각 열의 타이틀을 문자열(String) 값으로 넘겨주는 델리게이트 메서드
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        <#code#>
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imageView = UIImageView()
        imageView.image = images[row % images.count]
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }

    
    //사용자가 선택한 피커 뷰의 row를 사용하여 원하는 일을 하게하는 델리게이트 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedImgView.image = images[row]
        titleLbl.text = img[row]
    }
    
    
    //피커 뷰 row의 높이
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
}

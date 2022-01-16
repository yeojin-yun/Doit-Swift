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
        // context의 크기를 이미지뷰의 크기와 똑같이 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // context생성 : 일종의 도화지
        let context = UIGraphicsGetCurrentContext()
        
        //📍Drwa Line
        // 선의 굵기
        context?.setLineWidth(2.0)
        // 선의 색상
        context?.setStrokeColor(UIColor.red.cgColor)
        // 선의 시작점
        context?.move(to: CGPoint(x: 70, y: 70))
        // 선의 도착점
        context?.addLine(to: CGPoint(x: 270, y: 250))
        
        // 시작점과 도착점의 경로에 따라 그림을 그림
        context?.strokePath()
        
        
        //📍Drwa Triangle
        // 선의 굵기
        context?.setLineWidth(4.0)
        // 선의 색상
        context?.setStrokeColor(UIColor.blue.cgColor)
        // 선의 시작점
        context?.move(to: CGPoint(x: 170, y: 200))
        // 선의 도착점
        context?.addLine(to: CGPoint(x: 270, y: 350))
        context?.addLine(to: CGPoint(x: 70, y: 350))
        context?.addLine(to: CGPoint(x: 170, y: 200))
        // 시작점과 도착점의 경로에 따라 그림을 그림
        context?.strokePath()
        
        // 현재 context에 그려진 이미지를 가지고 와서 이미지 뷰에 나타냄
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 그림 그리기 끝내기
        UIGraphicsEndImageContext()
    }
    
    
    @objc func rectangleBtnTapped(_ sender: UIButton) {
        // context의 크기를 이미지뷰의 크기와 똑같이 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // context생성 : 일종의 도화지
        let context = UIGraphicsGetCurrentContext()
        
        //📍Drwa Rectangle
        // 선의 굵기
        context?.setLineWidth(2.0)
        // 선의 색상
        context?.setStrokeColor(UIColor.green.cgColor)
        // 사각형 위치 및 크기
        context?.addRect(CGRect(x: 50, y: 50, width: 50, height: 50))
        // 사각형 그리기
        context?.strokePath()
        
        // 현재 context에 그려진 이미지를 가지고 와서 이미지 뷰에 나타냄
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 그림 그리기 끝내기
        UIGraphicsEndImageContext()
        
    }
    @objc func circleBtnTapped(_ sender: UIButton) {
        // context의 크기를 이미지뷰의 크기와 똑같이 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // context생성 : 일종의 도화지
        let context = UIGraphicsGetCurrentContext()
        
        //📍Drwa Ellipse(타원)
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.magenta.cgColor)
        context?.addEllipse(in: CGRect(x: 50, y: 50, width: 50, height: 200))
        context?.strokePath()
        
        
        //📍Drwa Circle
        context?.setLineWidth(5.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 200))
        context?.strokePath()
        
        // 현재 context에 그려진 이미지를 가지고 와서 이미지 뷰에 나타냄
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 그림 그리기 끝내기
        UIGraphicsEndImageContext()
    }
    
    
    @objc func arcBtnTapped(_ sender: UIButton) {
        // context의 크기를 이미지뷰의 크기와 똑같이 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // context생성 : 일종의 도화지
        let context = UIGraphicsGetCurrentContext()
        
        //📍Drwa Arc1
        context?.setLineWidth(5.0)
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.move(to: CGPoint(x: 100, y: 50))
        context?.addArc(tangent1End: CGPoint(x: 250, y: 50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50))
        context?.addLine(to: CGPoint(x: 250, y: 200))
        context?.strokePath()
        
        //📍Drwa Arc2
        context?.setLineWidth(5.0)
        context?.setStrokeColor(UIColor.yellow.cgColor)
        context?.move(to: CGPoint(x: 100, y: 250))
        context?.addArc(tangent1End: CGPoint(x: 270, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context?.addLine(to: CGPoint(x: 100, y: 400))
        
        context?.strokePath()
        
        // 현재 context에 그려진 이미지를 가지고 와서 이미지 뷰에 나타냄
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 그림 그리기 끝내기
        UIGraphicsEndImageContext()
    }
    
    
    @objc func fillBtnTapped(_ sender: UIButton) {
        // context의 크기를 이미지뷰의 크기와 똑같이 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        // context생성 : 일종의 도화지
        let context = UIGraphicsGetCurrentContext()
        
        //📍Drwa Rectangle
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.yellow.cgColor)
        context?.setFillColor(UIColor.yellow.cgColor)
        
        let rectangle = CGRect(x: 70, y: 50, width: 200, height: 100)
        context?.addRect(rectangle)
        context?.fill(rectangle)
        context?.strokePath()
        
        
        //📍Drwa Rectangle
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        
        let circle = CGRect(x: 70, y: 200, width: 200, height: 100)
        context?.addEllipse(in: circle)
        context?.fillEllipse(in: circle)
        context?.strokePath()
        
        //📍Drwa Triangle
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setFillColor(UIColor.red.cgColor)
        
        context?.move(to: CGPoint(x: 170, y: 350))
        context?.addLine(to: CGPoint(x: 270, y: 450))
        context?.addLine(to: CGPoint(x: 70, y: 450))
        context?.addLine(to: CGPoint(x: 170, y: 350))
        context?.fillPath()
        context?.strokePath()
        
        // 현재 context에 그려진 이미지를 가지고 와서 이미지 뷰에 나타냄
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 그림 그리기 끝내기
        UIGraphicsEndImageContext()
        
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


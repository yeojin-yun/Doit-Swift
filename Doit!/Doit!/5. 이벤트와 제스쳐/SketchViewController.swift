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
    
    // 바로 전에 터치하거나 이동한 위치
    var lastPoint: CGPoint!
    // 선의 두께
    var lineSize: CGFloat = 2.0
    // 선의 색상
    var lineColor = UIColor.red.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    

}

//MARK: -Event
extension SketchViewController{
    @objc func clearBtnTapped(_ sender: UIButton) {
        // clear 버튼 누르면 이미지뷰 이미지 사라지도록
        imageView.image = nil
    }
    
    // 유저가 화면을 터치하면 스케치를 시작하도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 발생한 터치 이벤트를 가지고 와서 상수에 할당
        let touch = touches.first! as UITouch
        
        // 터치된 위치를 lastPoint라는 변수에 저장
        lastPoint = touch.location(in: imageView)
    }
    
    // 사용자가 터치한 손가락을 움직이면 스케치도 따라 움직이도록
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 둥글게
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currentPoint = touch.location(in: imageView)
        // 이미지뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        //lastPoint로 시작위치 이동
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        //lastPoint(이전위치)에서 currentPoint(현재위치)로 선을 추가
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
        // 추가한 선을 콘텍스트에 그림
        UIGraphicsGetCurrentContext()?.strokePath()
        // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지뷰에 할당
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        //그림 그리기 끝내기
        UIGraphicsEndImageContext()
        
        //현재 터치된 위치를 lastPoint 상수에 할당
        lastPoint = currentPoint
        print(#function)
    }
    
    
    // 사용자가 손가락을 떼었을 때 스케치가 끝나도록
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 둥글게
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        

        // 이미지뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        //lastPoint로 시작위치 이동
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        //lastPoint(이전위치)에서 currentPoint(현재위치)로 선을 추가
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(#function)
    }
    
    // 사용자가 기기 흔들었을 때 이미지 뷰 위에 그렸던 스케치가 지워지도록 
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imageView.image = nil
        }
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
        clearBtn.addTarget(self, action: #selector(clearBtnTapped(_:)), for: .touchUpInside)
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

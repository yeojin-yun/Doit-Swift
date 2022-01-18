//
//  TabTouchViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class TabTouchViewController: UIViewController {

    let mainLbl = UILabel()
    
    let messageLbl = UILabel()
    let rightMessageLbl = UILabel()
    let tapCountLbl = UILabel()
    let rightTapCounLbl = UILabel()
    let touchCountLbl = UILabel()
    let rightTouchCountLbl = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "스케치앱", style: .plain, target: self, action: #selector(barBtnTapped(_:)))
    }
    
    @objc func barBtnTapped(_ sender: UIBarButtonItem) {
        let nextVC = SketchViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }



}

//MARK: -Touch Event
extension TabTouchViewController {
    // 터치가 시작될 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        rightMessageLbl.text = "Touches Began"
        // touches 세트 안에 포함된 터치의 개수를 출력 / 연속으로 몇 번 탭했는지?
        rightTapCounLbl.text = String(touch.tapCount)
        // 터치 객체들 중 첫 번째 객체에서 탭의 개수 출력 / 몇 개의 손가락을 터치했는지?
        rightTouchCountLbl.text = String(touches.count)
    }
    
    // 터치된 손가락이 움직였을 때 호출되는 메서드
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        rightMessageLbl.text = "Touches Moved"
        // touches 세트 안에 포함된 터치의 개수를 출력 / 연속으로 몇 번 탭했는지?
        rightTapCounLbl.text = String(touch.tapCount)
        // 터치 객체들 중 첫 번째 객체에서 탭의 개수 출력 / 몇 개의 손가락을 터치했는지?
        rightTouchCountLbl.text = String(touches.count)
    }
    
    // 화면에서 손가락을 떼었을 떄 호출되는 메서드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        rightMessageLbl.text = "Touches Ended"
        // touches 세트 안에 포함된 터치의 개수를 출력 / 연속으로 몇 번 탭했는지?
        rightTapCounLbl.text = String(touch.tapCount)
        // 터치 객체들 중 첫 번째 객체에서 탭의 개수 출력 / 몇 개의 손가락을 터치했는지?
        rightTouchCountLbl.text = String(touches.count)
    }
}



//MARK: -UI
extension TabTouchViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        mainLbl.text = "Top/Touch"
        
        messageLbl.text = "Message"
        messageLbl.textAlignment = .left
        rightMessageLbl.text = "Touch Ended"
        //rightMessageLbl.textAlignment = .right
        
        tapCountLbl.text = "Tap Count"
        tapCountLbl.textAlignment = .left
        rightTapCounLbl.text = "6"
        //rightTapCounLbl.textAlignment = .right
        
        touchCountLbl.text = "Touch Count"
        touchCountLbl.textAlignment = .left
        rightTouchCountLbl.text = "1"
        
        [mainLbl, messageLbl, rightMessageLbl, tapCountLbl, rightTapCounLbl, touchCountLbl, rightTouchCountLbl].forEach {
            $0.textColor = UIColor.blue
            $0.backgroundColor = UIColor.yellow
        }
        
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        let stackView1 = UIStackView(arrangedSubviews: [messageLbl, rightMessageLbl])
        let stackView2 = UIStackView(arrangedSubviews: [tapCountLbl, rightTapCounLbl])
        let stackView3 = UIStackView(arrangedSubviews: [touchCountLbl, rightTouchCountLbl])
        
        
        [stackView1, stackView2, stackView3].forEach {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
        
        
        [mainLbl, stackView1, stackView2, stackView3].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            stackView1.topAnchor.constraint(equalTo: mainLbl.bottomAnchor, constant: 20),
            stackView1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 10),
            stackView2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 10),
            stackView3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
        ])
    }
}

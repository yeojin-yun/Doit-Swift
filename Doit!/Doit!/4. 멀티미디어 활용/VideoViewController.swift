//
//  VideoViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {

    let firstLbl = UILabel()
    let firstBtn = UIButton()
    let secondLbl = UILabel()
    let secondBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = UIColor(red: 240.0 / 255.0, green: 237.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    

}

//MARK: -Event
extension VideoViewController {
    // 내부 비디오 재생
    @objc func firstBtnTapped(_ sender: UIButton) {
        // 비디오가 저장된 내부의 파일 경로를 받아옴
        let filePath = Bundle.main.path(forResource: "Mountaineering", ofType: "mov")
        //let filePath = Bundle.main.path(forResource: "FastTyping", ofType: "mp4") //🚨안됨🚨
        
        //앱 내부의 파일명을 URL 형태로 변경
        //if let url = URL(fileURLWithPath: filePath!)
        
        //옵셔널 바인딩
        if let safePath = filePath {
            let url = URL(fileURLWithPath: safePath)
            playVideo(url: url)
        }
        
    }
    
    // 외부 미디어 재생
    @objc func secondBtnTapped(_ sender: UIButton) {
        // 외부 링크를 URL 형식으로 변경
        //let url = URL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        //playVideo(url: url)
        
        //옵셔널 바인딩
        if let safeURL = URL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4") {
            playVideo(url: safeURL)
        }
    }
    
    private func playVideo(url: URL) {
        // AVPlayerViewController 인스턴스 생성
        let playerController = AVPlayerViewController()
        
        // AVPlayer의 인스턴스 생성
        let player = AVPlayer(url: url as URL)
        
        // AVPlayerViewController의 player 속성에 AVPlayer의 인스턴스 할당
        playerController.player = player
        
        // 비디오 재생
        self.present(playerController, animated: true) {
            player.play()
        }

    }
}


//MARK: -UI
extension VideoViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        firstLbl.text = "앱 내부 비디오 재생"
        firstLbl.textAlignment = .center
        secondLbl.text = "앱 외부 비디오 재생"
        secondLbl.textAlignment = .center
        firstBtn.setImage(UIImage(named: "Mountaineering.jpg"), for: .normal)
        secondBtn.setImage(UIImage(named: "Fireworks"), for: .normal)

        
        firstBtn.addTarget(self, action: #selector(firstBtnTapped(_:)), for: .touchUpInside)
        secondBtn.addTarget(self, action: #selector(secondBtnTapped(_:)), for: .touchUpInside)
        
        [firstLbl, secondLbl].forEach {
            $0.layer.cornerRadius = 40
            $0.textColor = UIColor(red: 240.0 / 255.0, green: 237.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
            $0.backgroundColor = UIColor(red: 2.0 / 255.0, green: 52.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
        }
    }
    final private func setConstraints() {
        [firstLbl, secondLbl, firstBtn, secondBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            firstLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            firstLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            firstLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            firstLbl.heightAnchor.constraint(equalToConstant: 50),
            
            
            firstBtn.topAnchor.constraint(equalTo: firstLbl.bottomAnchor, constant: 10),
            firstBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            firstBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            firstBtn.heightAnchor.constraint(equalToConstant: 200),
            
            
            secondLbl.topAnchor.constraint(equalTo: firstBtn.bottomAnchor, constant: 30),
            secondLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            secondLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            secondLbl.heightAnchor.constraint(equalTo: firstLbl.heightAnchor),
            
            
            secondBtn.topAnchor.constraint(equalTo: secondLbl.bottomAnchor, constant: 10),
            secondBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            secondBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            secondBtn.heightAnchor.constraint(equalTo: firstBtn.heightAnchor),
            
        ])
    }
}

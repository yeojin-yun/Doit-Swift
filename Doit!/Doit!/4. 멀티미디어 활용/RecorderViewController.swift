//
//  RecorderViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/26.
//

import UIKit
import AVFoundation


class RecorderViewController: UIViewController {
    
    let mainLbl = UILabel()
    let progressBar = UIProgressView()
    var currentTimeLbl = UILabel()
    var endTimeLbl = UILabel()
    var recordBtn = UIButton()
    var playBtn = UIButton()
    var stopBtn = UIButton()
    let volumeSlider = UISlider()
    
    var progressTimer: Timer!
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer: AVAudioPlayer!
    
    var fileName: String = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupRecorder()
        playBtn.isEnabled = false
        
    }
    
}





extension RecorderViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    func getDocumentsDirector() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFileName = getDocumentsDirector().appendingPathComponent(fileName)
        let recordSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey: 320000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey: 44100.2] as [String: Any]
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print("error")
        }
    }
    
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = volumeSlider.value
        } catch {
            print("error")
        }
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.isEnabled = true
        currentTimeLbl.text = convertNSTimerIntervalToString(0)
    }
    
    @objc func updateTime() {
        currentTimeLbl.text = convertNSTimerIntervalToString(soundPlayer.currentTime)
        endTimeLbl.text = convertNSTimerIntervalToString(soundPlayer.duration)
        progressBar.progress = Float(soundPlayer.currentTime / soundPlayer.duration)
    }
    
    func convertNSTimerIntervalToString(_ time: TimeInterval) -> String{
        // time을 파라미터로 받아 재생 시간의 '분' 계산하여 정수로 저장
        let min = Int(time / 60)
        
        // time을 60으로 나눈 나머지 값을 정수 값으로 저장
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        
        // 위의 두 값을 "%02d:%02d" 형식으로 저장하여 상수에 저장
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
}

//MARK: -Event
extension RecorderViewController {
    @objc func recordBtnTapped(sender: UIButton) {
        if recordBtn.titleLabel?.text == "Record" {
            soundRecorder.record()
            endTimeLbl.text = convertNSTimerIntervalToString(0)
            recordBtn.setTitle("Stop", for: .normal)
            playBtn.isEnabled = false
        } else {
            soundRecorder.stop()
            recordBtn.setTitle("Record", for: .normal)
            //playBtn.isEnabled = false
            endTimeLbl.text = convertNSTimerIntervalToString(soundRecorder.currentTime)
        }
        
    }
    @objc func playBtnTapped(_ sender: UIButton) {
        //        if playBtn.titleLabel?.text == "Play" {
        //            playBtn.setTitle("Stop", for: .normal)
        //            recordBtn.isEnabled = false
        //            setupPlayer()
        //            soundPlayer.play()
        //        } else {
        //            soundPlayer.stop()
        //            playBtn.setTitle("Play", for: .normal)
        //            recordBtn.isEnabled = false
        //        }
        setupPlayer()
        soundPlayer.play()
        recordBtn.isEnabled = false
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func stopBtnTapped(_ sender: UIButton) {
        print(#function)
        soundPlayer.stop()
    }
    
//    @objc func sliderChanged(_ sender: UIButton) {
//        soundPlayer.volume = volumeSlider.value
//    }
}


//MARK: -UI
extension RecorderViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
        addTarget()
    }
    final private func setAttributes() {
        mainLbl.text = "Recorder"
        mainLbl.font = UIFont.boldSystemFont(ofSize: 30)
        recordBtn.setTitle("Record", for: .normal)
        recordBtn.setTitleColor(.white, for: .normal)
        recordBtn.backgroundColor = .purple
        recordBtn.layer.cornerRadius = 10
        playBtn.setTitle("Play", for: .normal)
        stopBtn.setTitle("Stop", for: .normal)
        currentTimeLbl.text = "00:00"
        endTimeLbl.text = "00:00"
        endTimeLbl.textAlignment = .right
        volumeSlider.value = 0.5 //🚨🚨🚨🚨 5.0으로 설정했을 때 왜 슬라이더 초기값 설정이 안되는지? 
        //volumeSlider.setValue(6.0, animated: true)
        volumeSlider.maximumValue = 1.0
        progressBar.progress = 0.0
        
        [playBtn, stopBtn].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 10
        }
        
        
    }
    final private func addTarget() {
        //volumeSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        playBtn.addTarget(self, action: #selector(playBtnTapped(_:)), for: .touchUpInside)
        recordBtn.addTarget(self, action: #selector(recordBtnTapped(sender:)), for: .touchUpInside)
        stopBtn.addTarget(self, action: #selector(stopBtnTapped(_:)), for: .touchUpInside)
        
    }
    
    final private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [recordBtn, playBtn, stopBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        
        let lblStack = UIStackView(arrangedSubviews: [currentTimeLbl, endTimeLbl])
        lblStack.axis = .horizontal
        lblStack.distribution = .fillEqually
        
        [mainLbl, stackView, progressBar, volumeSlider, lblStack].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: mainLbl.bottomAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            lblStack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30),
            lblStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lblStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            volumeSlider.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 80),
            volumeSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 70),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
    }
}

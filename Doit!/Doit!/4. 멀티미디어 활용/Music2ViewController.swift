//
//  Music2ViewController.swift
//  Doit!
//
//  Created by 순진이 on 2022/01/05.
//

import UIKit
import AVFoundation

class Music2ViewController: UIViewController {

    let mainLbl = UILabel()
    let progressBar = UIProgressView()
    let currentLbl = UILabel()
    let endTimeLbl = UILabel()
    let playBtn = UIButton()
    let pauseBtn = UIButton()
    let stopBtn = UIButton()
    let volumeLbl = UILabel()
    let volumeSlider = UISlider()
    
    let recordLbl = UILabel()
    let recordSwitch = UISwitch()
    let recordBtn = UIButton()
    let recordTime = UILabel()
    
    //AVAudioPlayer를 위한 설정
    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    let maxVolume: Float = 10.0
    var progressTimer: Timer!
    
    
    //📻 녹음기를 위한 설정
    var audioRecorder: AVAudioRecorder! // 객체 찍어내기
    var isRecordMode = false // 녹음 기본 설정 (처음에는 녹음기가 비활성화 되어 있어야 함)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        selectAudioFile()
        initRecord()
    }
    
    @objc func updatePlayTime() {
        currentLbl.text = convertTimeInterval2String(audioPlayer.currentTime)
        progressBar.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
}
//MARK: -Delegate
extension Music2ViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
}

extension Music2ViewController {
    func convertTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time / 60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        playBtn.isEnabled = play
        pauseBtn.isEnabled = pause
        stopBtn.isEnabled = stop
    }
    
    func selectAudioFile() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
    }
    
    func initRecord() {
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32), // 포맷 : Apple Lossless
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue, // 음질 : 최대
            AVEncoderBitRateKey: 320000, // 비트율 320,000(320kbps)
            AVNumberOfChannelsKey: 2, // 오디오 채널 : 2
            AVSampleRateKey: 44100.0] as [String: Any] // 샘플률 44,100Hz
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self
        
        volumeSlider.value = 1.0
        audioRecorder.volume = volumeSlider.value
        currentLbl.text = convertTimeInterval2String(0)
        endTimeLbl.text = convertTimeInterval2String(0)
        //setPlayButtons(false, pause: false, stop: false)
    }
    
    func setRecordMode() {
        
    }
}

//MARK: -Event
extension Music2ViewController {
    @objc func audioBtnTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "play":
            audioPlayer.play()
            setPlayButtons(false, pause: true, stop: true)
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePlayTime), userInfo: nil, repeats: true)
        case "pause":
            audioPlayer.pause()
            setPlayButtons(true, pause: false, stop: true)
        case "stop":
            audioPlayer.stop()
            setPlayButtons(true, pause: true, stop: false)
            currentLbl.text = convertTimeInterval2String(0)
            setPlayButtons(true, pause: false, stop: false)
            progressTimer.invalidate()
        default:
            break
        }
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        audioPlayer.volume = volumeSlider.value
    }
}

//MARK: -UI
extension Music2ViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    final private func setAttributes() {
        mainLbl.text = "Audio Player"
        mainLbl.font = UIFont.boldSystemFont(ofSize: 23)
        //progressBar.progress = 0.0
        //currentLbl.text = "currenTime"
        //endTimeLbl.text = "endTime"
        endTimeLbl.textAlignment = .right
        playBtn.setTitle("Play", for: .normal)
        playBtn.setTitleColor(.black, for: .normal)
        pauseBtn.setTitle("Pause", for: .normal)
        pauseBtn.setTitleColor(.black, for: .normal)
        stopBtn.setTitle("Stop", for: .normal)
        stopBtn.setTitleColor(.black, for: .normal)
        volumeLbl.text = "Volume"
        recordLbl.text = "Record"
        recordLbl.textColor = .black
        recordBtn.setTitle("Record", for: .normal)
        recordBtn.setTitleColor(.black, for: .normal)
        //recordTime.text = convertNSTimerIntervalToString(0)
        
//        [playBtn, pauseBtn, stopBtn].forEach {
//            $0.addTarget(self, action: #selector(audioBtnTapped(_:)), for: .touchUpInside)
//        }
//        volumeSlider.addTarget(self, action: #selector(sliderTapped(_:)), for: .valueChanged)
//        recordSwitch.addTarget(self, action: #selector(switchTapeed(_:)), for: .valueChanged)
//        recordBtn.addTarget(self, action: #selector(recordBtnTapped(_:)), for: .touchUpInside)
    }
    final private func setConstraints() {
        let lblStack = UIStackView(arrangedSubviews: [currentLbl, endTimeLbl])
        lblStack.axis = .horizontal
        lblStack.distribution = .fillEqually
        
        
        let btnStack = UIStackView(arrangedSubviews: [playBtn, pauseBtn, stopBtn])
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        
        
        [mainLbl, progressBar, lblStack, btnStack, volumeLbl, volumeSlider, recordLbl, recordSwitch, recordBtn, recordTime].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: mainLbl.bottomAnchor, constant: 30),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            lblStack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30),
            lblStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lblStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            btnStack.topAnchor.constraint(equalTo: lblStack.bottomAnchor, constant: 30),
            btnStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            btnStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            volumeLbl.topAnchor.constraint(equalTo: btnStack.bottomAnchor, constant: 30),
            volumeLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            volumeSlider.topAnchor.constraint(equalTo: btnStack.bottomAnchor, constant: 30),
            volumeSlider.leadingAnchor.constraint(equalTo: volumeLbl.trailingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            recordLbl.topAnchor.constraint(equalTo: volumeLbl.bottomAnchor, constant: 50),
            recordLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            
            recordSwitch.topAnchor.constraint(equalTo: recordLbl.topAnchor),
            recordSwitch.leadingAnchor.constraint(equalTo: recordLbl.trailingAnchor, constant: 20),
            
            recordBtn.topAnchor.constraint(equalTo: recordLbl.bottomAnchor, constant: 40),
            recordBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            
            recordTime.topAnchor.constraint(equalTo: recordBtn.topAnchor, constant: 6),
            recordTime.leadingAnchor.constraint(equalTo: recordBtn.trailingAnchor, constant: 20),
            
        ])
    }
}

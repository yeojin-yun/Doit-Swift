//
//  MusicViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

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
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "녹음", style: .plain, target: self, action: #selector(rightBtnTapped(_:)))
        configureUI()
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            recordBtn.isEnabled = false
            recordTime.isEnabled = false
        } else {
            initRecord()
        }
    }
    
    @objc func rightBtnTapped(_ sender: UIButton) {
        let nextVC = Music2ViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: -Event
extension MusicViewController {
    @objc func audioBtnTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Play":
            audioPlayer.play()
            setPlayBtnSetting(play: false, pause: true, stop: true)
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        case "Pause":
            audioPlayer.pause()
            setPlayBtnSetting(play: true, pause: false, stop: true)
        case "Stop":
            audioPlayer.stop()
            // 정지하면 처음부터 재생해야 하므로, currentTime도 다시 초기값 0으로 셋팅 & 레이블 표시도 0으로 셋팅
            audioPlayer.currentTime = 0
            currentLbl.text = convertNSTimerIntervalToString(0)
            setPlayBtnSetting(play: true, pause: true, stop: false)
            // 타이머도 멈추어야 함
            progressTimer.invalidate()
        default:
            break
        }
    }
    
    @objc func updateTime() {
        currentLbl.text = convertNSTimerIntervalToString(audioPlayer.currentTime)
        progressBar.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    @objc func sliderTapped(_ sender: UISlider) {
        audioPlayer.volume = volumeSlider.value
    }
    
    @objc func switchTapeed(_ sender: UISwitch) {
        if sender.isOn { // 녹음모드일 때 -> 모든 재생 모드는 false가 되도록
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            recordTime.text = convertNSTimerIntervalToString(0)
            isRecordMode = true
            recordBtn.isEnabled = true
            recordTime.isEnabled = true
        } else { // 재생모드일 때 -> 모든 녹음 모드가 false가 되도록
            isRecordMode = false
            recordBtn.isEnabled = false
            recordTime.isEnabled = false
        }
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    @objc func recordBtnTapped(_ sender: UIButton) {
        // 버튼 이름이 "Record"면 녹음모드기 때문에 녹음 시작하고, 버튼을 "Stop"으로 변경
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateRecordTime), userInfo: nil, repeats: true)
        // 현재 녹음 중 -> 버튼을 "Record" 바꾸고, play버튼 활성화, 녹음한 파일 재생
        } else {
            audioRecorder.stop()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            playBtn.isEnabled = true
            initPlay()
        }
    }
    
    @objc func updateRecordTime() {
        recordTime.text = convertNSTimerIntervalToString(audioRecorder.currentTime)
    }
}

//MARK: -Delegate
extension MusicViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    // 📻 녹음 초기 셋팅
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
            print("Error-initRecord: \(error)")
        }
        audioRecorder.delegate = self
        volumeSlider.value = 1.0
        audioPlayer.volume = volumeSlider.value
        endTimeLbl.text = convertNSTimerIntervalToString(0)
        setPlayBtnSetting(play: false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory: \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive: \(error)")
        }
    }
    
    func initPlay() {
    
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay: \(error)")
        }
        
        volumeSlider.maximumValue = maxVolume // 슬라이더의 최대값 초기화
        volumeSlider.value = 1.0 // 볼륨을 1로 초기화
        progressBar.progress = 0.0 // ProgressBar의 초기값 0.0 설정
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = volumeSlider.value
        // 시작 시간 (00:00) 셋팅
        currentLbl.text = convertNSTimerIntervalToString(0)
        // 끝나는 시간 셋팅
        endTimeLbl.text = convertNSTimerIntervalToString(audioPlayer.duration)
        // 처음 시작할 때는 플레이 버튼만 누를 수 있고, 나머지 버튼은 비활성화 해야 함
        setPlayBtnSetting(play: true, pause: false, stop: false)
    }
    func convertNSTimerIntervalToString(_ time: TimeInterval) -> String {
        // time을 파라미터로 받아 재생 시간의 '분' 계산하여 정수로 저장
        let min = Int(time / 60)
        
        // time을 60으로 나눈 나머지 값을 정수 값으로 저장
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        
        // 위의 두 값을 "%02d:%02d" 형식으로 저장하여 상수에 저장
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func setPlayBtnSetting(play: Bool, pause: Bool, stop: Bool) {
        playBtn.isEnabled = play
        pauseBtn.isEnabled = pause
        stopBtn.isEnabled = stop
    }
    
    // 📻 녹음파일과 재생 파일이 안 겹치게 하기 (녹음모드 아닐 때만 url생성)
    func selectAudioFile() {
        if !isRecordMode { // 재생 모드일 때
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else { // 녹음 모드일 때는 새 파일인 "recordFile.m4a"가 생성됨
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
}


//MARK: -UI
extension MusicViewController {
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
        
        [playBtn, pauseBtn, stopBtn].forEach {
            $0.addTarget(self, action: #selector(audioBtnTapped(_:)), for: .touchUpInside)
        }
        volumeSlider.addTarget(self, action: #selector(sliderTapped(_:)), for: .valueChanged)
        recordSwitch.addTarget(self, action: #selector(switchTapeed(_:)), for: .valueChanged)
        recordBtn.addTarget(self, action: #selector(recordBtnTapped(_:)), for: .touchUpInside)
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

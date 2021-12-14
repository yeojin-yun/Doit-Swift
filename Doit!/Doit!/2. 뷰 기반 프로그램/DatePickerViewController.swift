//
//  DatePickerViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class DatePickerViewController: UIViewController {

    var mainLbl = UILabel()
    var nowLbl = UILabel()
    let datePicker = UIDatePicker()
    var choiceLbl = UILabel()
    
    //타이머 작업을 위한 셋팅
    let timeSelector:Selector = #selector(DatePickerViewController.upDateTime)
    let interval = 1.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(upDateTime), userInfo: nil, repeats: true)
    }
    
}
//MARK: -UI
extension DatePickerViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        
        //datePicker셋팅
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = .autoupdatingCurrent
        
        //레이블 셋팅
        mainLbl.text = "Date Picker에서 시간 선택"
        nowLbl.text = "현재시간: "
        choiceLbl.text = "선택시간: "
        

        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    final private func setLayout() {
        [mainLbl, nowLbl, datePicker,choiceLbl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            nowLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nowLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nowLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            datePicker.topAnchor.constraint(equalTo: nowLbl.bottomAnchor, constant: 50),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            choiceLbl.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 50),
            choiceLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            choiceLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm EEE"

        choiceLbl.text = "선택시간: " + dateFormatter.string(from: sender.date)
    }
    
    @objc func upDateTime() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        nowLbl.text = "현재시간: " + dateFormatter.string(from: date)

    }
}

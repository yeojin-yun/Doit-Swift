//
//  MapViewViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    let segment = UISegmentedControl(items: ["현재위치", "포스텍", "이지출판사"])
    let mapView = MKMapView()
    var locationLbl1 = UILabel()
    var locationLbl2 = UILabel()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    
    



}

//MARK: -UI
extension MapViewViewController: CLLocationManagerDelegate {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    final private func setAttributes() {
        //segment.insertSegment(withTitle: "Test", at: 1, animated: true) //세그먼트 추가
//        segment.insertSegment(action: <#T##UIAction#>, at: <#T##Int#>, animated: <#T##Bool#>)
//        segment.setAction(<#T##action: UIAction##UIAction#>, forSegmentAt: <#T##Int#>)
        locationLbl1.text = ""
        locationLbl2.text = ""
        
        
        locationManager.delegate = self
        //정확도 설정 (최고 수준)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.requestWhenInUseAuthorization()
        //위치 없데이트 시작
        locationManager.startUpdatingLocation()
        //위치 보기 속성을 true 설정
        mapView.showsUserLocation = true
        
        segment.addTarget(self, action: #selector(segmentTapped(_:)), for: .valueChanged)
    }
    
    func goLocation(latitudeVale: CLLocationDegrees, longtitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeVale, longtitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeVale: latitudeValue, longtitudeValue: longitudeValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeVale: (pLocation?.coordinate.latitude)!, longtitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!) { placemarks, error in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            self.locationLbl1.text = "현재 위치"
            self.locationLbl2.text = address
        }
        locationManager.stopUpdatingLocation()
    }
    
    
    //segment 선택했을 때 발생할 이벤트 메서드
    @objc func segmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.locationLbl1.text = ""
            self.locationLbl2.text = ""
            locationManager.startUpdatingLocation()
        case 1:
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.87605740000004, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            self.locationLbl1.text = "보고 있는 위치"
            self.locationLbl2.text = "한국폴리텍대학 강릉캠퍼스"
        case 2:
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱 ", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.locationLbl1.text = "보고 있는 위치"
            self.locationLbl2.text = "이지스퍼플리싱 출판사"
        default:
            break
        }
    }
    
    final private func setConstraints() {
        [segment, mapView, locationLbl1, locationLbl2].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            segment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            
            locationLbl1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationLbl1.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            
            locationLbl2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationLbl2.topAnchor.constraint(equalTo: locationLbl1.bottomAnchor, constant: 20)
        ])
    }
    
    
    

}

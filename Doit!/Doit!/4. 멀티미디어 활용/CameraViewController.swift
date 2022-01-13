//
//  CameraViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController {

    let imageView = UIImageView()
    let takePhotoBtn = UIButton()
    let loadPhotoBtn = UIButton()
    let takeVideoBtn = UIButton()
    let loadVideoBtn = UIButton()
    
    //Camera
    let imagePicker = UIImagePickerController()
    var captureImage: UIImage?
    var videoURL: URL?
    var flagImageSave = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    



}

//MARK: -Delegate
extension CameraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        //미디어가 사진이면
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            //사진을 가져옴
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            
            if flagImageSave {
                //사진을 포토라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage!, self, nil, nil)
            }
            
            //가져온 사진을 이미지 뷰에 출력
            imageView.image = captureImage
            
            //미디어가 비디오일 때
        } else if mediaType.isEqual(to: kUTTypeVideo as NSString as String) {
            if flagImageSave {
                //비디오를 가져옴
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                //비디오를 포토 라이브러리에 저장
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL!.relativePath, self, nil, nil)
            }
        }
        //현재의 뷰(이미지 피커) 제거
        self.dismiss(animated: true, completion: nil)
    }
    
    //사진, 비디오 촬영이나 선택을 취소했을 때 호출되는 델리게이트 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: -Event
extension CameraViewController {
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //사진 촬영 버튼
    @objc func takePhotoBtnTapped(_ sender: UIButton) {
        //카메라의 사용 가능 여부 (사용할 수 있을 때만 아래 내용 수행)
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            //카메라 촬영 후 저장 여부
            flagImageSave = true
            //imagePicker에 관한 설정
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            //카메라를 사용할 수 없을 때 나타내는 경고창
            myAlert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    //사진 불러오기 버튼
    @objc func loadPhotoTapped(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
    
    //동영상 촬영 버튼
    @objc func takeVideoTapped(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    //동영상 불러오기 버튼
    @objc func loadVideoTapped(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
}

//MARK: -UI
extension CameraViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
        addTarget()
    }
    final private func addTarget() {
        takePhotoBtn.addTarget(self, action: #selector(takePhotoBtnTapped(_:)), for: .touchUpInside)
        loadPhotoBtn.addTarget(self, action: #selector(loadPhotoTapped(_:)), for: .touchUpInside)
        takeVideoBtn.addTarget(self, action: #selector(takeVideoTapped(_:)), for: .touchUpInside)
        loadVideoBtn.addTarget(self, action: #selector(loadVideoTapped(_:)), for: .touchUpInside)
    }
    
    final private func setAttributes() {
        imageView.backgroundColor = .red
        takePhotoBtn.setTitle("사진 촬영", for: .normal)
        takeVideoBtn.setTitle("동영상 촬영", for: .normal)
        loadPhotoBtn.setTitle("사진 불러오기", for: .normal)
        loadVideoBtn.setTitle("동영상 불러오기", for: .normal)
        
        [takePhotoBtn, takeVideoBtn, loadVideoBtn, loadPhotoBtn].forEach {
            $0.setTitleColor(.red, for: .normal)
        }
        
    }
    final private func setConstraints() {
        let stack1 = UIStackView(arrangedSubviews: [takePhotoBtn, takeVideoBtn])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        
        let stack2 = UIStackView(arrangedSubviews: [loadPhotoBtn, loadVideoBtn])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        
        [imageView, stack1, stack2].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            stack1.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant: 15),
            stack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stack2.topAnchor.constraint(equalTo:stack1.bottomAnchor, constant: 20),
            stack2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

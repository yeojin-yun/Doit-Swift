//
//  TableViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class TableViewController: UIViewController {

    let tableView = UITableView()
    let barBtn = UIButton()

    
    var items = ["장보기", "송결과 약속", "스터디 준비"]
    var images = ["cart.png", "clock.png", "pencil.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        //self.navigationItem.rightBarButtonItems = [leftBtn, rightBtn]
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightBtnTapped(_:))), UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(leftBtnTapped(_:)))]
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightBtnTapped(_:)))
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(leftBtnTapped(_:)))
    }
    


}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //셀을 옆으로 밀면 삭제할 수 있도록
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    // 셀 삭제할 때 나타나는 문자열
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    @objc func rightBtnTapped(_ sender: UIBarButtonItem) {
        let nextVC = AddViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func leftBtnTapped(_ sender: UIBarButtonItem) {
        let nextVC = DetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

//MARK: -UI
extension TableViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
        setTable()
    }
    final private func setAttributes() {
        barBtn.setTitle("+", for: .normal)
//        barBtn.setImage(UIImage(named: "Add"), for: .normal)
        barBtn.setTitleColor(.black, for: .normal)
        //barBtn.addTarget(self, action: #selector(rightBtnTapped(_:)), for: .touchUpInside)
    }
    
    
    final private func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    final private func setConstraints() {
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
//            barBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            barBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            rightBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            rightBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
}


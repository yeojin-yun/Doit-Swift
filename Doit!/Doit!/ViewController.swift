//
//  ViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {

    let list = ["1. Hello! 아이폰 앱", "2. 뷰 기반 프로그램 직접 만들기", "3. 뷰 컨트롤러 기반 프로그램 만들기", "4. 멀티미디어 활용하기", "5. 이벤트와 제스쳐"]


    
    // MARK: -Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    
    // MARK: -Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setBasics()
        view.backgroundColor = .white
        self.navigationItem.title = "Do it! 아이폰 앱 만들기"
    }
    
    
}

// MARK: -UI
extension ViewController {
    final private func setLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    final private func setBasics() {
        //MARK: -Delegate, Data Source
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.register(<#tableViewHeader#>.self, forHeaderFooterViewReuseIdentifier: "<#identifier#>")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: -Delegate, Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ChapterViewController()
        nextVC.navigationItem.title = list[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

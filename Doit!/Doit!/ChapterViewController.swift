//
//  ChapterViewController.swift
//  Doit!
//
//  Created by 순진이 on 2021/12/12.
//

import UIKit

class ChapterViewController: UIViewController {

    let firstList = ["Hello World"]
    let secondList = ["ImageView", "Date Picker", "Pick View", "Alert", "Web View", "Map View"]
    let thirdList = ["Page Control", "TabBarController", "NavigationController", "TableViewController"]
    let forthList = ["Music", "Video", "Camera", "Core Graphics"]
    let fifthList = ["Tab & Touch", "Swipe Gesture", "Pinch Gesture"]
    
    var selectedList: [String] = []
    
    // MARK: -Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
}

// MARK: -UI
extension ChapterViewController {
    func setUI() {
        setLayout()
        setBasics()
        setTableView()
    }
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
    
    func setTableView() {
        switch self.navigationItem.title {
        case "1. Hello! 아이폰 앱":
            selectedList = firstList
        case "2. 뷰 기반":
            selectedList = secondList
        case "3. 뷰 컨트롤러 기반":
            selectedList = thirdList
        case "4. 멀티미디어 활용하기":
            selectedList = forthList
        case "5. 이벤트와 제스쳐":
            selectedList = fifthList
        default:
            break
        }
    }


}

//MARK: -Delegate, Data Source
extension ChapterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = selectedList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.accessoryType = .disclosureIndicator
        
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = .red
//        case 1:
//            cell.backgroundColor = .orange
//        case 2:
//            cell.backgroundColor = .yellow
//        case 3:
//            cell.backgroundColor = .green
//        case 4:
//            cell.backgroundColor = .blue
//        case 5:
//            cell.backgroundColor = .brown
//        case 6:
//            cell.backgroundColor = .purple
//        default:
//            break
//        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.navigationItem.title = selectedList[indexPath.row]
        switch self.navigationItem.title {
        case "1. Hello! 아이폰 앱":
            let nextVC = FirstViewController()
            nextVC.navigationItem.title = selectedList[indexPath.row]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.pushViewController(nextVC, animated: true)
        case "2. 뷰 기반":
            switch indexPath.row {//self.navigationItem.title {
            case 0://"ImageView":
                let nextVC = ImageViewViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 1://"Date Picker":
                let nextVC = DatePickerViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 2://"Pick View":
                let nextVC = PickerViewViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 3://"Alert":
                let nextVC = AlertViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 4://"Web View":
                let nextVC = WebViewViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 5://"Map View":
                let nextVC = MapViewViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }

        case "3. 뷰 컨트롤러 기반":
            switch indexPath.row {
            case 0:
                let nextVC = PageControlViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                //navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                let tabBar = UITabBarController()
                let nextVC = TabBarViewController()
                //let nav1 = UINavigationController(rootViewController: nextVC)
                let nextVC1 = ImageViewViewController()
                let nextVC2 = DatePickerViewController()
                
                let tabBarItem1 = UITabBarItem(title: "Top Rated", image: UIImage(systemName: "star.fill"), selectedImage: nil)
                let tabBarItem2 = UITabBarItem(title: "imgView", image: UIImage(systemName: "photo"), selectedImage: nil)
                let tabBarItem3 = UITabBarItem(title: "DatePicker", image: UIImage(systemName: "clock"), selectedImage: nil)
                
                nextVC.tabBarItem = tabBarItem1
                nextVC1.tabBarItem = tabBarItem2
                nextVC2.tabBarItem = tabBarItem3
                
                tabBar.setViewControllers([nextVC, nextVC1, nextVC2], animated: true)
                
                nextVC.navigationItem.title = selectedList[indexPath.row]
                //navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(tabBar, animated: true)
            case 2:
                let nextVC = NavigationViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 3:
                let nextVC = TableViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }
        case "4. 멀티미디어 활용하기":
            switch indexPath.row {
            case 0:
                let nextVC = MusicViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                let nextVC = VideoViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 2:
                let nextVC = CameraViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 3:
                let nextVC = CoreGraphicsViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }
        case "5. 이벤트와 제스쳐":
            switch indexPath.row {
            case 0:
                let nextVC = TabTouchViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 1:
                let nextVC = SwipeGestureViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            case 2:
                let nextVC = PinchGestureViewController()
                nextVC.navigationItem.title = selectedList[indexPath.row]
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                break
            }
        default:
            break
        }
       
        
    }
    

}

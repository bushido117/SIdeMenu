//
//  SideMenuViewController.swift
//  SideMenuHW
//
//  Created by Вадим Сайко on 23.09.22.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: SideMenuViewController.MenuOptions)
}

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: SideMenuViewControllerDelegate?
    enum MenuOptions: String, CaseIterable {
        case profile = "Profile"
        case info = "Information"
        case appRating = "App rating"
        case shareApp = "Share App"
        case setting = "Settings"
        
        var imageName: String {
            switch self {
            case .profile:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                return "message"
            case .setting:
                return "gear"
            }
        }
    }
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.bounds.size.width,
            height: view.bounds.size.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)
        cell.contentView.backgroundColor = UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}

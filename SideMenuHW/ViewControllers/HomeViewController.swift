//
//  HomeViewController.swift
//  SideMenuHW
//
//  Created by Вадим Сайко on 23.09.22.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?
    var viewC: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 20, y: 100, width: 100, height: 100)
        view.backgroundColor = .purple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        view.addSubview(viewC)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(didTapMenuButton))
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
}

//
//  InfoViewController.swift
//  SideMenuHW
//
//  Created by Вадим Сайко on 23.09.22.
//

import UIKit

class InfoViewController: UIViewController {
    var viewC: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        view.backgroundColor = .purple
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewC)
        title = "Info"
        view.backgroundColor = .red
    }
}

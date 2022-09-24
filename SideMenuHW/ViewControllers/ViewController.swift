//
//  ViewController.swift
//  SideMenuHW
//
//  Created by Вадим Сайко on 23.09.22.
//

import UIKit

class ViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    let menuVC = SideMenuViewController()
    let homeVC = HomeViewController()
    lazy var infoVC = InfoViewController()
    private var menuState = MenuState.closed
    var blurView = UIVisualEffectView()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }

    private func addChildVCs() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    func sideMenuMoves() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) { [weak self] in
                self?.navVC?.view.frame.origin.x = (self?.homeVC.view.frame.size.width ?? .zero) - 100
                let blur = UIBlurEffect(style: .light)
                self?.blurView.frame = self?.view.bounds ?? .zero
                self?.blurView.effect = blur
                let vibraEf = UIVibrancyEffect(blurEffect: blur)
                let vibraView = UIVisualEffectView(effect: vibraEf)
                vibraView.frame = self?.view.bounds ?? .zero
                self?.blurView.contentView.addSubview(vibraView)
                self?.homeVC.view.addSubview(self!.blurView)
                self?.menuState = .opened
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) { [weak self] in
                self?.navVC?.view.frame.origin.x = 0
                self?.blurView.removeFromSuperview()
                self?.menuState = .closed
            }
        }
    }
}

extension ViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        sideMenuMoves()
    }
}
extension ViewController: SideMenuViewControllerDelegate {
    func didSelect(menuItem: SideMenuViewController.MenuOptions) {
        sideMenuMoves()
        switch menuItem {
            case .home:
                self.resetToHome()
            case .info:
                self.addInfo()
            case .appRating:
                break
            case .shareApp:
                break
            case .setting:
                break
        }
    }
    func addInfo() {
        let vc = infoVC
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.removeFromParent()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
}

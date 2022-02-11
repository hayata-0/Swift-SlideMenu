import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }

    private func addChildVCs() {
        //MENU
        //子要素に追加
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //HOME
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: HomeViewControllerDelegate{
    func didTapMenuButton() {
        switch menuState {
            case .closed:
                //開く処理
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                } completion: {[weak self] done in
                    if done{
                        self?.menuState = .opened
                    }
                }

            case .opened:
                //閉じる処理
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    self.navVC?.view.frame.origin.x = 0
                } completion: {[weak self] done in
                    if done{
                        self?.menuState = .closed
                    }
                }
        }
    }
}

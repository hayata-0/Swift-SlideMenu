import UIKit

class ContainerViewController: UIViewController {
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()

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
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }

}


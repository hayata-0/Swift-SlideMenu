import UIKit

protocol HomeViewControllerDelegate:AnyObject {
    func didTapMenuButton()
}


class HomeViewController: UIViewController {
    
    weak var delegate:HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "HOME"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(didTapMenuButton))
        
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}

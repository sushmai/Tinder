

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 10
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

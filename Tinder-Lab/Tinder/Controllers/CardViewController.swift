
import UIKit

class CardViewController: UIViewController {

    @IBOutlet var profilePicImageView: UIImageView!
    var cardInitialCenter: CGPoint!
    var holdInitialCenter: CGPoint!
    var initialTouchLocation: CGPoint!
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardInitialCenter = profilePicImageView.center
        holdInitialCenter = profilePicImageView.center
        profilePicImageView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onTapProfilePic(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    
    @IBAction func onPanProfilePic(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began{
            print(initialTouchLocation)
            print(cardInitialCenter)
        } else if sender.state == .changed {
            if(initialTouchLocation.y<cardInitialCenter.y){
                profilePicImageView.transform = CGAffineTransform(rotationAngle: translation.x * (CGFloat.pi/180) * 0.15)
            } else {
                profilePicImageView.transform = CGAffineTransform(rotationAngle: -translation.x * (CGFloat.pi/180) * 0.15)
            }
            
            profilePicImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
        } else if sender.state == .ended {
            if translation.x>100{
                UIView.animate(withDuration: 0.5) {
                    self.profilePicImageView.center.x = 1000
                }
            } else if translation.x < -100 {
                UIView.animate(withDuration: 0.5) {
                    self.profilePicImageView.center.x = -1000
                }
            } else {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.profilePicImageView.transform = CGAffineTransform.identity
                                self.profilePicImageView.center = self.holdInitialCenter
                }, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        initialTouchLocation = touches.first!.location(in: view)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfileViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        fadeTransition = FadeTransition()
        vc.transitioningDelegate = fadeTransition
        vc.profileImageView = profilePicImageView
    }
}


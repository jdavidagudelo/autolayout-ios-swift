//
//  ViewController.swift
//  AutoLayout
//
//  Created by Ingenieria y Software on 21/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var aspectRatioConstraint: NSLayoutConstraint?{
        willSet{
            if let existingConstraint = aspectRatioConstraint{
                view.removeConstraint(existingConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint{
                view.addConstraint(newConstraint)
            }
        }
    }
    var image: UIImage?
        {
        get{return imageView.image}
        set{
            imageView.image = image
            if let constrainedView = imageView{
                if let newImage = newValue
                {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }
                else
                {
                    aspectRatioConstraint = nil
                }
            }
        
        }
    }
    var secure: Bool = false{
        didSet{
            updateUI()
        }
    }
    var loggedInUser: User?{
        didSet{
            updateUI()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateUI()
    {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secure Password":"Password"
        companyLabel.text = loggedInUser?.company ?? ""
        nameLabel.text = loggedInUser?.name ?? ""
        imageView.image = loggedInUser?.image
        image = loggedInUser?.image
    }
    @IBAction func toggleSecurity(sender: UIButton){
        secure = !secure
    }
    @IBAction func login(sender: UIButton)
    {
        loggedInUser = User.login(userNameField.text ?? "", password: passwordField.text ?? "")
        
    }
}
extension UIImage
{
    var aspectRatio: CGFloat
        {
            return size.height != 0 ? size.width/size.height : 0
    }
}
extension User{
    var image: UIImage? {
        if let image = UIImage(named: login)
        {
            return image
        }
        return UIImage(named: "unknown_user")
    }
}
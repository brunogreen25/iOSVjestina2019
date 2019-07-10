//
//  LoginView.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation
import UIKit

class LoginView: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var defaultAccessToken: Int = 0
    var defaultUserId: Int = 0
    var isLoggedIn: Bool=false
    
    //za AutoLayout
    var labelUsername: UILabel!
    var textFieldUsername: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonLoginA: UIButton!
    
    //kad prelazimo na drugi view da vratimo elemente
    override func viewDidDisappear(_ animated: Bool) {
        self.resfresh()
    }
    
    //animacija se pojavljuje svaki put kad se ekran ucita
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //kad budes spreman za AutoLayout onda ovo pozovi
        //setUpLoginView()
        
        
        checkForUserDefaults()
        self.usernameTF.text="36508693"
        self.passwordTF.text="36508693"
    }
    @IBAction func buttonLoginClicked(_ sender: Any) {
        fetchLogins()
    }
    
    func hightenAlpha(_ view: UIView) {
        view.alpha+=1
    }
    
    func moveRight(_ view: UIView) {
        view.center.x+=300
    }
    
    func moveUp(_ view: UIView) {
        view.center.y-=300
    }
    
    func moveDown(_ view: UIView) {
        view.center.y+=300
    }
    
    func lowerAlpha(_ view: UIView) {
        view.alpha-=1
    }
    
    func resfresh() {
        self.moveDown(self.titleLabel)
        self.moveDown(self.usernameTF)
        self.moveDown(self.passwordTF)
        self.moveDown(self.loginButton)
    }
    
    func disappear() {
        self.moveUp(self.titleLabel)
        self.moveUp(self.usernameTF)
        self.moveUp(self.passwordTF)
        self.moveUp(self.loginButton)
    }
    
    func appearingAnimation() {
        self.passwordTF.center.x-=300
        self.usernameTF.center.x-=300
        self.loginButton.center.x-=300
        
        self.passwordTF.alpha=0
        self.usernameTF.alpha=0
        self.loginButton.alpha=0
        self.titleLabel.alpha=0
        
        //ukupno vrijeme=2+0.5*2=3
        let duration: Double=2.0
        let delay: Double=0.5
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [],animations: {
            self.moveRight(self.usernameTF)
            self.hightenAlpha(self.usernameTF)
        })
        UIView.animate(withDuration: duration, delay: delay, options: [],animations: {
            self.moveRight(self.passwordTF)
            self.hightenAlpha(self.passwordTF)
        })
        //.curveEaseout metoda ona za usporavanje u options
        UIView.animate(withDuration: duration, delay: delay*2, options: [],animations: {
            self.moveRight(self.loginButton)
            self.hightenAlpha(self.loginButton)
        })
        
        self.titleLabel.transform=CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: duration+2*delay, animations: {
            self.hightenAlpha(self.titleLabel)
            self.titleLabel.transform=CGAffineTransform.identity
        })
    }
    
    func exitingAnimation() {
        //ukupno vrijeme 2+3*0.5=3.5
        let duration: Double=2.0
        let delay: Double=0.5
        //curve ease out
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut],animations: {
            self.moveUp(self.titleLabel)
            self.lowerAlpha(self.titleLabel)
        })
        
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseOut],animations: {
            self.moveUp(self.usernameTF)
            self.lowerAlpha(self.usernameTF)
        })
        
        UIView.animate(withDuration: duration, delay: delay*2, options: [.curveEaseOut],animations: {
            self.moveUp(self.passwordTF)
            self.lowerAlpha(self.passwordTF)
        })
        
        UIView.animate(withDuration: duration, delay: delay*3, options: [.curveEaseOut],animations: {
            self.moveUp(self.loginButton)
            self.lowerAlpha(self.loginButton)
        }) {(_) in //finished
            self.changeView()
        }
    }
    
    func setUpLoginView(){
        //setup mogu izbrisat cijeli
        //ovako se dodaje label username (ali ti bi triba dodat 5 elemenata I PAZIT DA IH TIPKOVNICA NE PREKRIJE)
        self.labelUsername=UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 21))
        self.labelUsername.text="usernamee"
        self.view.addSubview(self.labelUsername)
        
        self.labelUsername.translatesAutoresizingMaskIntoConstraints=false
        var constraint = NSLayoutConstraint(item: self.labelUsername, attribute:
            NSLayoutConstraint.Attribute.centerX, relatedBy:
            NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:
            NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([constraint])
        constraint = NSLayoutConstraint(item: self.labelUsername, attribute:
            NSLayoutConstraint.Attribute.centerY, relatedBy:
            NSLayoutConstraint.Relation.equal, toItem: self.view, attribute:
            NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([constraint])
        
        /*
         self.textFieldUsername=UITextField()
         constraint = NSLayoutConstraint(item: self.textFieldUsername, attribute:
         NSLayoutConstraint.Attribute.centerX, relatedBy:
         NSLayoutConstraint.Relation.equal, toItem: self.labelUsername, attribute:
         NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 50)
         self.view.addConstraint(constraint)
         
         self.labelPassword=UILabel()
         constraint = NSLayoutConstraint(item: self.labelPassword, attribute:
         NSLayoutConstraint.Attribute.centerY, relatedBy:
         NSLayoutConstraint.Relation.equal, toItem: self.labelUsername, attribute:
         NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
         self.view.addConstraint(constraint)
         
         self.textFieldUsername=UITextField()
         constraint = NSLayoutConstraint(item: self.textFieldUsername, attribute:
         NSLayoutConstraint.Attribute.centerX, relatedBy:
         NSLayoutConstraint.Relation.equal, toItem: self.labelUsername, attribute:
         NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 50)
         self.view.addConstraint(constraint)
         
         self.buttonLoginA=UIButton()
         constraint = NSLayoutConstraint(item: self.buttonLoginA, attribute:
         NSLayoutConstraint.Attribute.centerY, relatedBy:
         NSLayoutConstraint.Relation.equal, toItem: self.labelUsername, attribute:
         NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
         self.view.addConstraint(constraint)
         
         */
    }
    
    func fetchLogins() {
        
        let urlString = "https://iosquiz.herokuapp.com/api/session"
        
        let loginService = LoginService()
        let username = self.usernameTF.text!
        let password = self.passwordTF.text!
        
        loginService.fetchLogin(username: username, password: password, urlString: urlString){
            (accessToken, userId) in
            
            if let accessToken=accessToken{
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                //UserDefaults.standard.synchronize()
                
                UserDefaults.standard.set(userId, forKey: "user_id")
                //UserDefaults.standard.synchronize()
                
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                //UserDefaults.standard.synchronize()
                
                DispatchQueue.main.async {
                    self.exitingAnimation()
                }
            } else {
                //Display an Alert message
            }
        }
    }
    
    /*func displayAlertMessage(_ message: String)
    {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        var myAlert=UIAlertController(title: "Try again!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        /*AKO ZELIS DODAT TEXTFIELD U ALERT
         myAlert.addTextField {
         (textField) in
         textField.placeholder="Name"
         textField.keyboardType=.numberPad  --TIPKOVNICA SU BROJEVI
         }*/
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(myAlert, animated: true)
        }
    }*/
    
    
    
    func checkForUserDefaults() {
        // self.defaultAccessToken=UserDefaults.standard.integer(forKey: "userAccessToken")
        // self.defaultUserId=UserDefaults.standard.integer(forKey: "userId")
        
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if self.isLoggedIn == true {
            self.changeView()
            
            DispatchQueue.main.async {
                self.disappear()
            }
        }
    }
    
    func changeView() {
        /*
         let window: UIWindow?
         window=UIWindow(frame: UIScreen.main.bounds)
         
         let vc=TabBarController()
         window?.rootViewController=vc
         window?.makeKeyAndVisible()
         window?.isHidden=false
         
         let ap=AppDelegate().window
         ap?.rootViewController=TabBarController()
         ap?.makeKeyAndVisible()*/
        
        
        //UINib(nibName: "InitialViewController", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InitialViewController
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController = TabBarController()
        ad.window?.makeKeyAndVisible()
    }
    
    
}

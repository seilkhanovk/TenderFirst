//
//  LoginViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 18.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    let tenderFirstURl = "https://tender1st.kz/api/login"
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var name: String?
    var stream: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        mobileTextField.setBottomBorder()
        mobileTextField.attributedPlaceholder = NSAttributedString(string: "Телефон", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        passwordTextField.setBottomBorder()
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        button.layer.cornerRadius = 5
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
     
        
        if (passwordTextField.text?.isEmpty)! || (mobileTextField.text?.isEmpty)! {
            displayMessage(userMessage: "Пожалуйста, заполните все поля")
        } else {
            
            let params: [String: String] = ["phoneNumber": mobileTextField.text!, "password": passwordTextField.text!]
            
            activity(showActivity: false)
            
            getPersonalData(url: tenderFirstURl, parameters: params)
        }
        
    }
    
    func getPersonalData(url: String, parameters: [String : String]) {
      
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                self.activity(showActivity: false)
                print(response.result.value)
                let userJSON: JSON = JSON(response.result.value)
                
                let err = userJSON["err"].stringValue
               
                if err == "invalid phone number or password" {
                    self.displayMessage(userMessage: "Пользователя не существует")
                } else {
                    self.name = userJSON["user"]["firstname"].stringValue + " " + userJSON["user"]["lastname"].stringValue
                    self.stream = userJSON["user"]["stream"].stringValue
                    self.email = userJSON["user"]["email"].stringValue
                    let accessToken = userJSON["token"].stringValue
                    
                    KeychainWrapper.standard.set(self.name!, forKey: "name")
                    KeychainWrapper.standard.set(self.stream!, forKey: "stream")
                    KeychainWrapper.standard.set(self.email!, forKey: "email")
                    KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                    
                    if userJSON["user"]["passwordChanged"].intValue == 1{
                        
                        self.performSegue(withIdentifier: "menu", sender: self)
                        
                    } else {
                        self.performSegue(withIdentifier: "password", sender: self)
                    }
                }
                
            } else {
                    print("Error \(response.result.error)")
                    self.displayMessage(userMessage: "Проблема с подключением к интернету")
                }
            
            }
        
        }
    
    func displayMessage(userMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
   
    func activity(showActivity: Bool) {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        if showActivity == false {
            DispatchQueue.main.async {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.removeFromSuperview()
            }
        }
        
    }
    
}

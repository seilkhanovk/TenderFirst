//
//  ChangePasswordViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 24.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    let url = "https://tender1st.kz/api/user/changePassword"
    var arrayOfStreams : [String] = []
    
    var id = [String:Int]()
    let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        newPasswordTextField.setBottomBorder()
        newPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Новый пароль", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        repeatPasswordTextField.setBottomBorder()
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Подтвердите пароль", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        sendButton.layer.cornerRadius = 5
        
        let streamURL = "https://tender1st.kz/api/stream?token=\(accessToken!)"
        streamData(url: streamURL)
    }
    
    func streamData(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let streamJSON: JSON = JSON(response.result.value!)
                print(response.result.value)
                for index in 0...streamJSON["streams"].count - 1 {
                    let stream = streamJSON["streams"][index]["name"].stringValue
                    let streamID = streamJSON["streams"][index]["id"].intValue
                    self.arrayOfStreams.append(stream)
                    let dict: [String:Int] = [stream:streamID]
                    self.id[stream] = streamID
               //     print(self.id)
                }
            } else {
                print("error \(response.result.error)")
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        if (newPasswordTextField.text?.isEmpty == true || repeatPasswordTextField.text?.isEmpty == true) {
            displayMessage(userMessage: "Заполните все поля.")
        }
        
        if (newPasswordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true {
            displayMessage(userMessage: "Пароли не совпадают.")
            newPasswordTextField.text = ""
            repeatPasswordTextField.text = ""
        } else {
         
            let token: String = KeychainWrapper.standard.string(forKey: "accessToken")!
            
            let parameters: [String: String] = ["password": newPasswordTextField.text!, "confirmPassword": repeatPasswordTextField.text!, "token": token]
            
            changePassword(params: parameters)
        }
        
    }
    
    func changePassword(params: [String:String]) {
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
                controller.streams = self.arrayOfStreams
                controller.idd = self.id
                self.present(controller, animated: true, completion: nil)

                print(response.result.value)
            } else {
                print("error \(response.result.error)")
            }
        }
        
    }

    
    func displayMessage(userMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) in
                DispatchQueue.main.async {
                   // self.dismiss(animated: true, completion: nil)
                }
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

}

//
//  FormViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 21.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var iinTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var streamTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    
    
    let cities = ["Астана", "Алматы"]
    var streams: [String]?
    var idd = [String : Int]()
    var pickerView = UIPickerView()
    let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        nameTextField.setBottomBorder()
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        surnameTextField.setBottomBorder()
        surnameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        iinTextField.setBottomBorder()
        iinTextField.attributedPlaceholder = NSAttributedString(string: "ИИН", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        emailTextField.setBottomBorder()
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Почта", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        streamTextField.setBottomBorder()
        streamTextField.attributedPlaceholder = NSAttributedString(string: "Выберите поток", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        cityTextField.setBottomBorder()
        cityTextField.attributedPlaceholder = NSAttributedString(string: "Выберите город", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if (nameTextField.text?.isEmpty)! || (surnameTextField.text?.isEmpty)! || (iinTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (streamTextField.text?.isEmpty)! || (cityTextField.text?.isEmpty)! {
            displayMessage(userMessage: "Пожалуйста, заполните все поля")
        }
        
        changePersonalData()
    }
    
   

    func changePersonalData() {
        
        let name = nameTextField.text
        let surname = surnameTextField.text
        let iin = iinTextField.text
        let email = emailTextField.text
        let city = cityTextField.text
        let stream = streamTextField.text
        let tenderFirstURL = "https://tender1st.kz/api/user/fillForm?token=\(accessToken!)"

        let params: [String:String] = ["name": name!, "surname": surname!, "iin": iin!, "email": email!, "city": city!, "stream": "\(idd[stream!]!)"]

//        print("name \(name), surname \(surname), iin \(iin), email \(email), city \(city), stream \(stream)")
//            let params: [String:String] = ["name": "Kuanysh", "surname": "Seilk", "iin": "950314339433", "email": "seil@ku.com", "city": "Астана", "stream": "12"]
//
        Alamofire.request(tenderFirstURL, method: .put, parameters: params).responseJSON {(response) in
            if response.result.isSuccess {
                print(response.result.value)
                let nameSurname = name! + " " + surname!
                KeychainWrapper.standard.set(nameSurname, forKey: "name")
                KeychainWrapper.standard.set(stream!, forKey: "stream")
                KeychainWrapper.standard.set(email!, forKey: "email")
                
                self.performSegue(withIdentifier: "formMenu", sender: self)
                
            } else {
                print("Error \(response.result.error)")
                self.displayMessage(userMessage: "Проблема с подключением к интернету")
            }
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countOfRows: Int = cities.count
        if pickerView == pickerView2 {
            countOfRows = streams!.count
        }
        return countOfRows
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerView1 {
            let title = cities[row]
            return title
        } else {
            if pickerView == pickerView2 {
                let title = streams![row]
                return title
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            cityTextField.text = cities[row]
            pickerView1.isHidden = true
        } else {
            streamTextField.text = streams![row]
            pickerView2.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == cityTextField {
            pickerView1.isHidden = false
            
        } else {
            if textField == streamTextField {
                pickerView2.isHidden = false
            }
        }
    }
    
    func displayMessage(userMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: userMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                DispatchQueue.main.async {
                    //self.dismiss(animated: true, completion: nil)
                }
            })
           alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension UITextField {
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

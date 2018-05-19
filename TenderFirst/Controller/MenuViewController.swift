//
//  MenuViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 23.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var settingTableView: UITableView!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streamLabel: UILabel!
    

    let elements = ["Главная", "Мероприятия", "Кураторы групп", "Задания", "Новости", "FAQ", "О нас", "Техподдержка", "Выход"]
    let imageElemts = ["user", "calendar", "users", "success", "newspaper", "paper-plane", "share", "settings", "exit"]

    let name = KeychainWrapper.standard.string(forKey: "name")
    let stream = KeychainWrapper.standard.string(forKey: "stream")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        if (stream == "Поток 1") {
            streamLabel.text = stream
        } else {
            streamLabel.text = "Поток \(stream!)"
        }
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.isScrollEnabled = false
        
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "TFIcon")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = settingTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomSettingsTableViewCell
            cell.settingLabel.text = elements[indexPath.row]
            cell.iconImage.image = UIImage(named: imageElemts[indexPath.row])
            cell.selectionStyle = .none
            return cell
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 49
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 8 {
            self.performSegue(withIdentifier: imageElemts[indexPath.row], sender: self)
        } else {
            KeychainWrapper.standard.removeObject(forKey: "accessToken")
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let signIn = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = signIn
        }

    }
    
    
    
}

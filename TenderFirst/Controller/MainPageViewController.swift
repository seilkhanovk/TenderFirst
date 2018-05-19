//
//  MainPageViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 23.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MainPageViewController: BaseViewController{

    
  //  @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    @IBOutlet weak var viewOfTableView: UIView!
    
    var nameString : [String] = []
    var titleString = ["Имя", "Эл. почта", "Поток", "След. занятия"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userTableView.delegate = self
//        userTableView.dataSource = self
//        userTableView.isScrollEnabled = false
        
        print("hey")
       print( viewOfTableView.frame.size.height)
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "TFIcon")
        
        let name = KeychainWrapper.standard.string(forKey: "name")
        nameString.append(name!)
        let email = KeychainWrapper.standard.string(forKey: "email")
        nameString.append(email!)
        let stream = KeychainWrapper.standard.string(forKey: "stream")
        nameString.append(stream!)
        nameString.append("28.03.2018")
        
//        self.userTableView.estimatedRowHeight = 68
//        self.userTableView.rowHeight = UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titleString.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = userTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
//        cell.titleLabel.text = titleString[indexPath.row]
//        cell.itemLabel.text = nameString[indexPath.row]
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//        print("\(userTableView)")
//        return 68
//    }
//
//
   
    

}

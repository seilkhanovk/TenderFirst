//
//  CurratorsViewController.swift
//  
//
//  Created by Kuanysh on 24.04.2018.
//

import UIKit

class CurratorsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var curatorsTableView: UITableView!
    
    var names = [ "Айгул",  "Портнягин", "Артур", "Ксения", "Руни", "Роналду",  "Байдильда"]
    
    var photos = ["1", "2", "3", "4", "5", "6", "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curatorsTableView.delegate = self
        curatorsTableView.dataSource = self
        curatorsTableView.isScrollEnabled = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = curatorsTableView.dequeueReusableCell(withIdentifier: "curators") as! CuratorsTableViewCell
        cell.nameLabel.text = names[indexPath.row]
       // cell.imageView?.image = UIImage(named: photos[indexPath.row])
       cell.curatorImageView.image = UIImage(named: photos[indexPath.row])
        cell.streamLabel.text = "Поток \(photos[indexPath.row])"
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

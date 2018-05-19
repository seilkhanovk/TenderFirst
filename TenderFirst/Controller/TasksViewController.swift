//
//  TasksViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 25.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var taskTableView: UITableView!
    
    var first = ["Взять ключи ЭЦП на физ лицо", "Открыть ТОО", "Шаблоны док", "Печать", "Пойти в ЦОН", "Отсканировать доки", "Счеть в банке"]
    var second = ["ЦОНы по районам", "ссылка на бум варианте", "Адиль", " ", "и активировать ключи", "и поставить печать", "через 1 день"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return first.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "task") as! TasksTableViewCell
        cell.firstLabel.text = first[indexPath.row]
        cell.secondLabel.text = second[indexPath.row]
        cell.successImage.image = #imageLiteral(resourceName: "success")
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 88
    }
    
}

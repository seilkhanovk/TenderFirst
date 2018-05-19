//
//  FaqViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 24.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FaqViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var faqTableView: UITableView!
    
    var tableViewData = [cellData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqTableView.delegate = self
        faqTableView.dataSource = self

        tableViewData = [cellData(opened: false, title: "Кто вы?", sectionData: ["Мы TenderFirst!"])]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = faqTableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = faqTableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            faqTableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            faqTableView.reloadSections(sections, with: .none)
        }
    }
    
    

}

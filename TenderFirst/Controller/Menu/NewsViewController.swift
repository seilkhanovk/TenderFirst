//
//  NewsViewController.swift
//  TenderFirst
//
//  Created by Kuanysh on 24.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    var heading = ["Adobe Photoshop", "Adobe Photoshop", "Adobe Photoshop", "Adobe Photoshop"]
    var content = ["Browse the latest Adobe Illustrator CC tutorials, video tutorials, hands-on projects, and more. Ranging from beginner to advanced, these tutorials provide basics, new features, plus tips and techniques.", "Browse the latest Adobe Illustrator CC tutorials, video tutorials, hands-on projects, and more. Ranging from beginner to advanced, these tutorials provide basics, new features, plus tips and techniques.", "Browse the latest Adobe Illustrator CC tutorials, video tutorials, hands-on projects, and more. Ranging from beginner to advanced, these tutorials provide basics, new features, plus tips and techniques.", "Browse the latest Adobe Illustrator CC tutorials, video tutorials, hands-on projects, and more. Ranging from beginner to advanced, these tutorials provide basics, new features, plus tips and techniques."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heading.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! EventCollectionViewCell
        cell.authorLabel.text = "Батырхан Орынкул"
        cell.contentLabel.text = content[indexPath.row]
        cell.titleLabel.text = heading[indexPath.row]
        return cell
    }

}

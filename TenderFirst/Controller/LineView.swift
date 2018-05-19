//
//  LineView.swift
//  TenderFirst
//
//  Created by Kuanysh on 23.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

class LineView: UIView {

    var line = UIBezierPath()
    
    func graph() {
        line.move(to: .init(x: 0, y: bounds.height/2))
        line.addLine(to: .init(x: bounds.width, y: bounds.height/2))
        UIColor.gray.setStroke()
        line.lineWidth = 1
        line.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        graph()
    }

}

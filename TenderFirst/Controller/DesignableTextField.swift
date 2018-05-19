//
//  DesignableTextField.swift
//  TenderFirst
//
//  Created by Kuanysh on 22.04.2018.
//  Copyright © 2018 KuanyshTeam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage? {
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 30))
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            view.addSubview(imageView)
            imageView.image = image
            leftView = view
            
        } else {
            leftViewMode = .never
        }
    }

}

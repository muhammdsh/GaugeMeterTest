//
//  PushButton.swift
//  Canvas
//
//  Created by Muhammed Shatara on 03/05/2023.
//

import UIKit

@IBDesignable class PushButton: UIButton {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }

}

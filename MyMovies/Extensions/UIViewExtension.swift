//
//  UIViewExtension.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}

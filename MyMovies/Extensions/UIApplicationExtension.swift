//
//  UIApplicationExtension.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/21/20.
//

import CoreStore

extension UIApplication {

    static var appDelegate: AppDelegate {
        return shared.delegate as! AppDelegate
    }
    static var dataStack: DataStack {
        return appDelegate.dataStack
    }

}

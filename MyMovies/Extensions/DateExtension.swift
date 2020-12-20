//
//  DateExtension.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import Foundation

extension Date {

    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }

}

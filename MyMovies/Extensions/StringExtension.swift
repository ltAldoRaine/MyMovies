//
//  StringExtension.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import Foundation

extension String {

    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }

}


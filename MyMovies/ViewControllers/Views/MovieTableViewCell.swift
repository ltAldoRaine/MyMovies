//
//  MovieTableViewCell.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let description = "MovieTableViewCell"
    static let nib = UINib(nibName: description, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

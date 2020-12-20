//
//  MovieCollectionViewCell.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    static let description = "MovieCollectionViewCell"
    static let nib = UINib(nibName: description, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
    }

}

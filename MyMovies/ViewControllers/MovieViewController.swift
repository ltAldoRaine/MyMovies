//
//  MovieViewController.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
    }

    private func fillUI() {
        guard let movie = movie else { return }
        title = movie.title
        if let posterPath = movie.posterPath, let url = URL(string: Network.moviePoster(posterPath)) {
            posterImageView.kf.setImage(with: url)
        }
        if let voteAverage = movie.voteAverage {
            ratingLabel.text = "\(voteAverage)"
        }
        releaseDateLabel.text = movie.releaseDate?.toDate(format: "yyyy-MM-dd").toString(format: "MMM d, yyyy")
        originalTitleLabel.text = movie.originalTitle
        overviewLabel.text = movie.overview
    }

}

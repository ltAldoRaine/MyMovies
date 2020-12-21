//
//  MovieViewController.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit
import CDAlertView

class MovieViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movieViewModel: MovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
    }

    @IBAction func onAddToFavoritesViewTapped() {
        CDAlertView(title: "Favorites", message: "Movie has been successfully added to the favorites", type: .success).show()
    }

    private func fillUI() {
        guard let movieViewModel = movieViewModel else { return }
        title = movieViewModel.title
        if let posterPath = movieViewModel.posterPath, let url = URL(string: Network.moviePoster(posterPath)) {
            posterImageView.kf.setImage(with: url)
        }
        if let voteAverage = movieViewModel.voteAverage {
            ratingLabel.text = "\(voteAverage)"
        }
        releaseDateLabel.text = movieViewModel.releaseDate?.toDate(format: "yyyy-MM-dd").toString(format: "MMM d, yyyy")
        originalTitleLabel.text = movieViewModel.originalTitle
        overviewLabel.text = movieViewModel.overview
    }

}

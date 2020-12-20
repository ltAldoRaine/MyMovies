//
//  MoviesCollectionViewController.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class MoviesCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let wSpace: CGFloat = minimumInteritemSpacing + sectionInset.left + sectionInset.right
        let hSpace: CGFloat = minimumLineSpacing + sectionInset.top + sectionInset.bottom
        let width = (collectionView.frame.width - wSpace) / 2.0
        let height = (collectionView.frame.height - hSpace) / 3.0
        itemSize = CGSize(width: width, height: height)
    }

}

class MoviesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    private let moviesAPI = MoviesAPI()

    private var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.description)
        getUpcomingMovies()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.description, for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        if let posterPath = movie.posterPath, let url = URL(string: Network.moviePoster(posterPath)) {
            cell.posterImageView.kf.setImage(with: url)
        }
        cell.title.text = movie.title
        return cell
    }

    private func getUpcomingMovies() {
        activityIndicatorView.startAnimating()
        moviesAPI.upcoming()
            .done { data -> Void in
                self.activityIndicatorView.stopAnimating()
                self.movies = data
                self.collectionView.reloadData()
            }
            .catch { error in print(error.localizedDescription) }
    }

}

//
//  MoviesTableViewController.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.description)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.description, for: indexPath) as! MovieTableViewCell
        return cell
    }

}

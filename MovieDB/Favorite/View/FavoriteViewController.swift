//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: "FavoriteTableViewCell")
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        return cell
    }
    
    
}

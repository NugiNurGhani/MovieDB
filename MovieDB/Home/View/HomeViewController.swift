//
//  HomeViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    var imageArray: [UIImage] = [#imageLiteral(resourceName: "PosterEx"), #imageLiteral(resourceName: "PosterEx"), #imageLiteral(resourceName: "PosterEx"), #imageLiteral(resourceName: "PosterEx")]
    
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var movieDBLabel: UILabel!
    @IBOutlet weak var imageBannerView: UIImageView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
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
        notificationImageView.image = notificationImageView.image?.withRenderingMode(.alwaysTemplate)
        notificationImageView.tintColor = UIColor.white
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: "PosterCollectionViewCell")
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
    }


    func setupCollection() {
        let layout = UICollectionViewLayout()
        popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 145)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 //imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
        //cell.posterImage.image = imageArray[indexPath.row]
        return cell
    }
    
    
}
//
//  AllViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit
import SDWebImage

class AllViewController: UIViewController {
    
    var topRatedPosterImage: [UIImageView] = []
    var dummyImage =  UIImageView()
    var titleArray: [String] = []
    var scores: [Double] = []
    var poster: UIImageView?
    var viewModel = MovieViewModel()
    var topRatedPosterURLArray: [String] = []
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
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
        dummyImage.image = #imageLiteral(resourceName: "BannerEx")
        
        viewModel.getTopRatedMovies()
        
        for _ in 0...9 {
            topRatedPosterImage.append(dummyImage)
            topRatedPosterURLArray.append("")
            titleArray.append("")
            scores.append(0.0)
        }
        
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        topRatedCollectionView.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: "PopularCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.topRatedMovie.count != 0 {
            for i in 0..<topRatedPosterURLArray.count {
                topRatedPosterURLArray[i] = K.imgURL+viewModel.topRatedMovie[i].posterPath
                titleArray[i] = viewModel.topRatedMovie[i].title
                scores[i] = viewModel.topRatedMovie[i].voteAverage
                poster?.sd_setImage(with: URL(string: topRatedPosterURLArray[i]))
                topRatedPosterImage[i] = poster ?? dummyImage
            }
            
//            print("popular: \(popularPosterURLArray)")
            
            DispatchQueue.main.async {
                self.topRatedCollectionView.reloadData()
            }
        }
    }
}

extension AllViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.topRatedCollectionView.frame.size.width)/2.1, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
        cell.popularImageView.sd_setImage(with: URL(string: topRatedPosterURLArray[indexPath.row]))
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.castLabel.text = "Score: \(scores[indexPath.row])"
        return cell
    }
    
    
}

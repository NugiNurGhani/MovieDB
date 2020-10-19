//
//  RecommendationViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit
import SDWebImage

class RecommendationViewController: UIViewController {
    
    var popularPosterImage: [UIImageView] = []
    var dummyImage =  UIImageView()
    var titleArray: [String] = []
    var scores: [Double] = []
    var poster: UIImageView?
    var viewModel = MovieViewModel()
    var popularPosterURLArray: [String] = []
    
    @IBOutlet weak var searchedLabel: UILabel!
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
        dummyImage.image = #imageLiteral(resourceName: "BannerEx")
        
        searchedLabel.isHidden = true
        
        viewModel.getPopularMovies()
        
        for _ in 0...9 {
            popularPosterImage.append(dummyImage)
            popularPosterURLArray.append("")
            titleArray.append("")
            scores.append(0.0)
        }
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: "PopularCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.popularMovie.count != 0 {
            for i in 0..<popularPosterURLArray.count {
                popularPosterURLArray[i] = K.imgURL+viewModel.popularMovie[i].posterPath
                titleArray[i] = viewModel.popularMovie[i].title
                scores[i] = viewModel.popularMovie[i].voteAverage
                poster?.sd_setImage(with: URL(string: popularPosterURLArray[i]))
                popularPosterImage[i] = poster ?? dummyImage
            }
            
//            print("popular: \(popularPosterURLArray)")
            
            DispatchQueue.main.async {
                self.popularCollectionView.reloadData()
            }
        }
    }
}

extension RecommendationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.popularCollectionView.frame.size.width)/2.1, height: 360)
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
        cell.popularImageView.sd_setImage(with: URL(string: popularPosterURLArray[indexPath.row]))
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.castLabel.text = "Score: \(scores[indexPath.row])"
        return cell
    }
    
    
}

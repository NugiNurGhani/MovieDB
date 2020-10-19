//
//  HomeViewController.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    var popularPosterImage: [UIImageView] = []
    var comingSoonPosterImage: [UIImageView] = []
    var poster: UIImageView?
    var testModel = MovieViewModel()
    var bannerImage: [UIImageView] =  []
    var changeImageCounter = 0
    var popularPosterURLArray: [String] = ["", "", "", "", "", "", "", "", "", "" ]
    var comingSoonPosterURLArray: [String] = ["", "", "", "", "", "", "", "", "", "" ]
    
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var movieDBLabel: UILabel!
    @IBOutlet weak var imageBannerView: UIImageView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var comingSoonCollectionView: UICollectionView!
    
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
        let mdl = "MovieDB"
        let attributedLabel = NSMutableAttributedString(string: mdl)
        attributedLabel.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.9844155908, green: 0.8242375851, blue: 0, alpha: 1), range: NSRange(location: 5, length: 2))
        movieDBLabel.attributedText = attributedLabel
        testModel.getPopularMovies()
        testModel.getComingSoonMovies()
        for _ in 0...9 {
            popularPosterImage.append(imageBannerView)
            comingSoonPosterImage.append(imageBannerView)
        }
        notificationImageView.image = notificationImageView.image?.withRenderingMode(.alwaysTemplate)
        notificationImageView.tintColor = UIColor.white
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        comingSoonCollectionView.delegate = self
        comingSoonCollectionView.dataSource = self
        popularCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: "PosterCollectionViewCell")
        comingSoonCollectionView.register(PosterCollectionViewCell.nib(), forCellWithReuseIdentifier: "PosterCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if testModel.popularMovie.count != 0 {
            imageBannerView.sd_setImage(with: URL(string: K.imgURL+testModel.popularMovie[Int.random(in: 0..<10)].backdropPath!))
            
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            
            for i in 0..<popularPosterURLArray.count {
                popularPosterURLArray[i] = K.imgURL+testModel.popularMovie[i].posterPath
                poster?.sd_setImage(with: URL(string: popularPosterURLArray[i]))
                popularPosterImage[i] = poster ?? imageBannerView
            }
            print("popular: \(popularPosterURLArray)")
            DispatchQueue.main.async {
                self.popularCollectionView.reloadData()
            }
        }
        if testModel.comingSoonMovie.count != 0 {
            for i in 0..<comingSoonPosterURLArray.count {
                comingSoonPosterURLArray[i] = K.imgURL+testModel.comingSoonMovie[i].posterPath
                poster?.sd_setImage(with: URL(string: comingSoonPosterURLArray[i]))
                comingSoonPosterImage[i] = poster ?? imageBannerView
            }
            print("comingSoon: \(comingSoonPosterURLArray)")
            DispatchQueue.main.async {
                self.comingSoonCollectionView.reloadData()
            }
        }
    }
    @objc func changeImage() {
        imageBannerView.sd_setImage(with: URL(string: K.imgURL+testModel.popularMovie[Int.random(in: 0..<10)].backdropPath!))
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
            cell.posterImage.sd_setImage(with: URL(string: popularPosterURLArray[indexPath.row]))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as! PosterCollectionViewCell
            cell.posterImage.sd_setImage(with: URL(string: comingSoonPosterURLArray[indexPath.row]))
            return cell
        }
        
    }
}

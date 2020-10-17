//
//  PosterCollectionViewCell.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "PosterCollectionViewCell", bundle: nil)
    }
}



//
//  PopularCollectionViewCell.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 18/10/20.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class func nib() -> UINib {
        return UINib(nibName: "PopularCollectionViewCell", bundle: nil)
    }
}

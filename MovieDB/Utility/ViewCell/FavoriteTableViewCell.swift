//
//  FavoriteTableViewCell.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 18/10/20.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favYear: UILabel!
    @IBOutlet weak var favGenre: UILabel!
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favPressed(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "FavoriteTableViewCell", bundle: nil)
    }
    
}

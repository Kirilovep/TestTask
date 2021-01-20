//
//  PhotoTableViewCell.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit
import Kingfisher
protocol PhotoCellDelegate: class {
    func sharePressed(cell: PhotoTableViewCell)
}

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: - Properties -
    var newImageView: UIImageView?
    var delegate : PhotoCellDelegate?
    //MARK:- IBOutlets -
    @IBOutlet weak var avatarImageView: UIImageView!

    
    //MARK:- LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Functions -
    func configure(resultId: String, resultSecret: String) {
        let urlPhoto = "\(HelperUrl.loadPhotoUrl.rawValue)0/\(resultId)_\(resultSecret)_b.jpg"
        let photoUrl = URL(string: urlPhoto)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: photoUrl, placeholder: UIImage(named: "placeholder"))
    }
    
    //MARK:- IBActions -
    @IBAction func buttonPress(_ sender: UIButton) {
        delegate?.sharePressed(cell: self)
    }
}

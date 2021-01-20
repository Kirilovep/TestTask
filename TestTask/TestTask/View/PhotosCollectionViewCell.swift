//
//  PhotosCollectionViewCell.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import UIKit
import Kingfisher
class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var photosImageView: UIImageView!
    
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //MARK: - Functions -
    func configure(result: Photo) {
        if let resultId = result.id, let resultSecret = result.secret {
            let urlPhoto = "\(HelperUrl.loadPhotoUrl.rawValue)0/\(resultId)_\(resultSecret)_b.jpg"
            let photoUrl = URL(string: urlPhoto)
            photosImageView.kf.indicatorType = .activity
            photosImageView.kf.setImage(with: photoUrl)
        }
    }
}

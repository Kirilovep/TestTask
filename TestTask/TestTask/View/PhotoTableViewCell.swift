//
//  PhotoTableViewCell.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

protocol PhotoCellDelegate: class {
    func buttonPressed(cell: PhotoTableViewCell)
}

class PhotoTableViewCell: UITableViewCell {
    
    var delegate:PhotoCellDelegate?

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var newImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
      
        
    }
  
    
    @IBAction func buttonPress(_ sender: UIButton) {
        if let imageUrl = URL(string: "https://picsum.photos/200") {
            self.avatarImageView.load(url: imageUrl, indicator: activityIndicator)
            //newImageView = avatarImageView
        }
        delegate?.buttonPressed(cell: self)
    }
}

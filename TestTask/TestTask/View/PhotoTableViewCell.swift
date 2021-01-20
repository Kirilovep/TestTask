//
//  PhotoTableViewCell.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: - Properties -
    var newImageView: UIImageView?
    
    //MARK:- IBOutlets -
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- IBActions -
    @IBAction func buttonPress(_ sender: UIButton) {
        if let imageUrl = URL(string: "https://picsum.photos/200") {
            self.avatarImageView.load(url: imageUrl, indicator: activityIndicator)
        }
    }
}

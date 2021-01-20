//
//  StaffTableViewCell.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets -
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //MARK:- LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Functions -
    func configure(result: WorkerEntity) {
        if let name = result.name, let secondName = result.secondName, let imageData = result.imageData {
            nameLabel.text = name
            surnameLabel.text = secondName
            avatarImageView.image = UIImage(data: imageData)
        }
    }
}

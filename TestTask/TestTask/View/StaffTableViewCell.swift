//
//  StaffTableViewCell.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class StaffTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(result: WorkerEntity) {
        if let name = result.name, let secondName = result.secondName {
            nameLabel.text = name
            surnameLabel.text = secondName
        }
        
        
    }
    
}

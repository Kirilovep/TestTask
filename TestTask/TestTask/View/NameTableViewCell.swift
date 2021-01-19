//
//  NameTableViewCell.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

  
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

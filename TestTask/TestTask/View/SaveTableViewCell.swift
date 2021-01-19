//
//  SaveTableViewCell.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

protocol SaveCellDelegate: class {
    func sharePressed(cell: SaveTableViewCell)
}

class SaveTableViewCell: UITableViewCell {

    var delegate : SaveCellDelegate?
    
    @IBOutlet weak var saveButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    @IBAction func buttonPress(_ sender: UIButton) {
        delegate?.sharePressed(cell: self)

    }
    
    
    
}

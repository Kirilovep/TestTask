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

    //MARK:- Properties -
    var delegate : SaveCellDelegate?
    
    //MARK:- IBOutlets -
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK:- LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- IBActions -
    @IBAction func buttonPress(_ sender: UIButton) {
        delegate?.sharePressed(cell: self)
    }
}

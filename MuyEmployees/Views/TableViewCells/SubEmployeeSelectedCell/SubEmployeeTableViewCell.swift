//
//  SubEmployeeTableViewCell.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit

protocol SubEmployeeTableViewCellDelegate {
    func addSubEmployee(index: Int)
}

class SubEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    private var delegate : SubEmployeeTableViewCellDelegate?
    var indexRow : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDelegate(delegate: SubEmployeeTableViewCellDelegate){
        self.delegate = delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.addSubEmployee(index: indexRow ?? 0)
        }
    }
}

//
//  HeaderSubEmployeesSection.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderSubEmployeesSectionDelegate {
    func addNewSubEmployee()
}
class HeaderSubEmployeesSectionView : UIView{
    private var delegate : HeaderSubEmployeesSectionDelegate?
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDelegate(delegate: HeaderSubEmployeesSectionDelegate){
        self.delegate = delegate
    }
    
    //MARK: IBActions
    
    @IBAction func actionAddSubEmployee(_ sender: Any) {
        guard let delegate = self.delegate else {return}
        delegate.addNewSubEmployee()
    }
    
}

//
//  AddEmployeeViewModel.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

class AddEmployeeViewModel{
    private let employeeManager = EmployeesManager.get
    
    var employedAdded: (() -> Void)?
    
    var onFailure: (() -> Void)?
    
    func addEmployee(name: String, position: String, wage: Int){
        if let responseValue = employedAdded {
            employeeManager.addEmployee(name: name, position: position, wage: wage, responseValue: responseValue, onFailure: onFailure)
        }
    }

}

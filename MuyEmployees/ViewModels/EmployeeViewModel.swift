//
//  EmployeeViewModel.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

class EmployeeViewModel{
    private let employeeManager = EmployeesManager.get
    
    var employedDeleted: (() -> Void)?
    var employedEdited: (() -> Void)?
    
    var onFailure: (() -> Void)?
    
    func removeSubEmployee(subEmployed: SubEmployees){
        if let responseValue = employedDeleted {
            employeeManager.deleteSubEmployed(subEmployed: subEmployed, responseValue: responseValue, onFailure: onFailure)
        }
    }
    
    func editEmployee(employee: Employee, name: String, position: String, wage: Int){
        if let responseValue = employedEdited{
            employeeManager.editEmployee(employee: employee, name: name, position: position, wage: wage, responseValue: responseValue, onFailure: onFailure)
        }
    }
}

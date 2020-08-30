//
//  AddSubEmployeeViewModel.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

class AddSubEmployeeViewModel{
    private let employeeManager = EmployeesManager.get
    
    var employeesListRes: (([Employee]) -> Void)?
    var employeesFilteredListRes: (([Employee]) -> Void)?
    var addSubEmployeeToEmployeeRes: (() -> Void)?
   
    var onFailure: (() -> Void)?

    func getEmployeesList(){
        if let responseValue = employeesListRes {
            employeeManager.getEmployees(responseValue: responseValue, onFailure: onFailure)
        }
    }
    
    func getFilteredEmployees(text: String){
        if let responseValue = employeesFilteredListRes {
            employeeManager.getFilteredEmployees(text: text, responseValue: responseValue, onFailure: onFailure)
        }
    }
    
    func addSubEmployeeToEmployee(employee: Employee, name: String, id: Int){
        if let responseValue = addSubEmployeeToEmployeeRes{
            employeeManager.addSubEmployeeToEmployee(employee: employee, name: name, id: id, responseValue: responseValue, onFailure: onFailure)
        }
    }
}

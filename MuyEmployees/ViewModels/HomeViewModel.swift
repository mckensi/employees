//
//  HomeViewModel.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

class HomeViewModel{
    private let employeeManager = EmployeesManager.get
    
    var employeesListRes: (([Employee]) -> Void)?
    var employeesFilteredListRes: (([Employee]) -> Void)?
    var deleteEmployeeRes: (() -> Void)?
    
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
    
    func deleteEmployee(employee: Employee){
        if let responseValue = deleteEmployeeRes {
            employeeManager.deleteEmployee(employee: employee, responseValue: responseValue, onFailure: onFailure)
        }
    }
}

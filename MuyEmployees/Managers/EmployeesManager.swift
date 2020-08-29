//
//  EmployeesManager.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

class EmployeesManager: NSObject {
    static let get = EmployeesManager()
    
    private let employeesService = EmployeesService.get
    
    func getEmployees(responseValue: @escaping ([Employee]) -> Void, onFailure: (() -> Void)? = nil){
        employeesService.getEmployees(responseValue: responseValue, onFailure: onFailure)
    }
    
    func deleteSubEmployed(subEmployed: SubEmployees, responseValue: @escaping () -> Void, onFailure: (() -> Void)? = nil) {
        employeesService.deleteSubEmployee(subEmployee: subEmployed, responseValue: responseValue, onFailure: onFailure)
    }
    
    func editEmployee(employee: Employee, name: String, position: String, wage: Int, responseValue: @escaping () -> Void, onFailure: (() -> Void)? = nil){
        employeesService.editEmployee(employee: employee, name: name, position: position, wage: wage, responseValue: responseValue, onFailure: onFailure)
    }
    
    func addEmployee(name: String, position: String, wage: Int, responseValue: @escaping () -> Void, onFailure: (() -> Void)? = nil){
        employeesService.addEmployee(name: name, position: position, wage: wage, responseValue: responseValue, onFailure: onFailure)
    }
}

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
}

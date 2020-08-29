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
   
    var onFailure: (() -> Void)?

    func getEmployeesList(){
        if let responseValue = employeesListRes {
            employeeManager.getEmployees(responseValue: responseValue, onFailure: onFailure)
        }
    }
}

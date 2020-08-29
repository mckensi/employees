//
//  EmployeesService.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class EmployeesService {
    
    public static let get = EmployeesService()
    private var employees : [Employee]?
    
    public init() {}
    
    func getEmployees(responseValue: @escaping ([Employee]) -> Void,  onFailure: (() -> Void)? = nil){
        let url = EmpoyeesApi.baseUrl
        print(url)
        ApiAdapter.get.requestPokeDesk(url: url) { (response: AFDataResponse<EmployeesListRes>) in
            var employeeListRes = EmployeesListRes()
            
            if let statusCode = response.response?.statusCode{
                switch statusCode {
                case 200:
                    if let value = response.value {
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        employeeListRes = value
                        
                        
                        if let employeesInList = employeeListRes.employees{
                            for employee in employeesInList{
                                if !self.someEntityExists(id: employee.id ?? 0) {
                                    let employeePersist = Employee(context: context)
                                    employeePersist.id = Int64(employee.id ?? 0)
                                    employeePersist.name = employee.name
                                    employeePersist.position = employee.position
                                    employeePersist.wage = Int64("\(employee.wage ?? 0)") ?? 0
                                    
                                    do {
                                        try context.save()
                                        
                                        if let subEmployeesByEmployee = employee.employees{
                                            for subEmployeeRes in subEmployeesByEmployee{
                                                let subEmployee = SubEmployees(context: context)
                                                subEmployee.name = subEmployeeRes.name
                                                subEmployee.id = Int64(subEmployeeRes.id ?? 0)
                                                employeePersist.addToSubEmployees(subEmployee)
                                                
                                                do {
                                                    try context.save()
                                                }
                                                catch {
                                                    print("No pudimos guardar un subEmpleado")
                                                }
                                            }
                                        }
                                    }
                                    catch {
                                        print("No pudimos guardar la informacion localmente")
                                    }
                                }else{
                                    //MARK: Update registers if the services change the Data
                                    print("Registro ya guardado anteriormente")
                                }
                            }
                        }else{
                            onFailure?()
                        }
                        responseValue(self.getPersistData())
                    } else {
                        print("error getEmployees -> \(response.error.debugDescription)")
                        onFailure?()
                    }
                    
                default:
                    print("Error request status code: \(statusCode)")
                    onFailure?()
                }
            }else{
                onFailure?()
            }
            
        }
        
    }
    
    func getPersistData() -> [Employee]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            employees = try context.fetch(Employee.fetchRequest())
            return employees ?? [Employee]()
        }
        catch{
            print("Error al capturar la data persistida")
            return [Employee]()
        }
        
    }
    
    func someEntityExists(id: Int) -> Bool {
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var results: [NSManagedObject] = []
        
        do {
            results = try context.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    func deleteSubEmployee(subEmployee: SubEmployees, responseValue: @escaping () -> Void,  onFailure: (() -> Void)? = nil){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(subEmployee)
        do {
            try context.save()
            responseValue()
        }
        catch{
            print("error al borrar esta relación laboral")
            onFailure?()
        }
    }
    
    func editEmployee(employee: Employee, name: String, position: String, wage: Int, responseValue: @escaping () -> Void,  onFailure: (() -> Void)? = nil){
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        employee.name = name
        employee.position = position
        employee.wage = Int64("\(wage)") ?? 0
        
         do {
             try context.save()
             responseValue()
         }
         catch{
             print("error al borrar esta relación laboral")
             onFailure?()
         }
     }
    
    
    func addEmployee(name: String, position: String, wage: Int, responseValue: @escaping () -> Void,  onFailure: (() -> Void)? = nil){
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEmployee = Employee(context: context)
        newEmployee.name = name
        newEmployee.position = position
        newEmployee.wage = Int64("\(wage)") ?? 0
        
         do {
             try context.save()
             responseValue()
         }
         catch{
             print("error al borrar esta relación laboral")
             onFailure?()
         }
     }
    
    func getFilterEmployees(text: String, responseValue: @escaping ([Employee]) -> Void,  onFailure: (() -> Void)? = nil){
        do{
            let request = Employee.fetchRequest() as NSFetchRequest<Employee>
                   let pred = NSPredicate(format: "name CONTAINS %@", text)
                   request.predicate = pred
                   
                   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                   let filteredEmployees = try context.fetch(request)
            responseValue(filteredEmployees)
        }
        catch{
            onFailure?()
        }
        
    }
    
}

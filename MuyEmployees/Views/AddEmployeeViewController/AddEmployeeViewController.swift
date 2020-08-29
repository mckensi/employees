//
//  AddEmployeeViewController.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD

class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPosition: UITextField!
    @IBOutlet weak var textFieldWage: UITextField!
    
    private var viewModel = AddEmployeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initListener()
        // Do any additional setup after loading the view.
    }

    init(){
          super.init(nibName: "AddEmployeeViewController", bundle: nil)
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func initListener(){
        viewModel.employedAdded = {
            let banner = NotificationBanner(title: "Genial!", subtitle: "Has agregado un nuevo colaborador", style: .success)
                     banner.backgroundColor = .systemGreen
                     banner.show()
            SVProgressHUD.dismiss()
            self.navigationController?.popViewController(animated: true)
        }
        
        viewModel.onFailure = {
            SVProgressHUD.dismiss()
            let banner = NotificationBanner(title: "Error", subtitle: "Ha sucedido un error guardando, trabajamos para solucionarlo.", style: .danger)
                     banner.backgroundColor = .systemRed
                     banner.show()
            SVProgressHUD.dismiss()
        }
    }
      
    func save(){
        var allTheFieldsAreCompleted = true
        if let name = textFieldName.text {
            if name == ""{
                allTheFieldsAreCompleted = false
            }
        }
        
        if let position = textFieldPosition.text {
            if position == ""{
                allTheFieldsAreCompleted = false
            }
        }
        
        if let wage = textFieldWage.text {
            if wage == ""{
                allTheFieldsAreCompleted = false
            }
        }
        
        if allTheFieldsAreCompleted{
            let name = textFieldName.text ?? ""
            let position = textFieldPosition.text ?? ""
            let wage = Int(textFieldWage.text ?? "0") ?? 0
            viewModel.addEmployee(name: name, position: position, wage: wage)
            SVProgressHUD.show()
        }else{
            let banner = NotificationBanner(title: "Error", subtitle: "Por favor llena todos los campos", style: .warning)
            banner.backgroundColor = .systemRed
            banner.show()
        }
    }
    
    @IBAction func actionAddEmployee(_ sender: Any) {
        save()
    }
}

//
//  ViewController.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = HomeViewModel()
    var emplooyes : [Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        initListener()
        SVProgressHUD.show()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getEmployeesList()
    }
    
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        let nibCell = UINib(nibName: "EmplooyeTableViewCell", bundle: nil)
        tableView.register(nibCell.self, forCellReuseIdentifier: "employeeCell")
    }
    
    
    
    private func initListener(){
        viewModel.employeesListRes = { [weak self] response in
            guard let strongSelf = self else {return}
            strongSelf.emplooyes = response
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
            
        }
        
        viewModel.onFailure = {
            let banner = NotificationBanner(title: "Error", subtitle: "Ocurrio un problema con tu busqueda, trabajamos para resolverlo.", style: .danger)
            banner.backgroundColor = .systemYellow
            banner.show()
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func actionAddEmployee(_ sender: Any) {
        let vc = AddEmployeeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EmployeeViewController()
        
        if let employee = emplooyes?[indexPath.row]{
            vc.employee = employee
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
        
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emplooyes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as? EmplooyeTableViewCell
        cell?.labelName.text = emplooyes?[indexPath.row].name
        cell?.labelPosition.text = emplooyes?[indexPath.row].position
        return cell ?? UITableViewCell()
    }
    
    
}

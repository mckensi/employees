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
    private var viewModel = HomeViewModel()
    private var emplooyes : [Employee]?
    private var emplooyesToShow:  [Employee]? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let searchBarController = UISearchController(searchResultsController: nil)
    private var searchText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        initListener()
        SVProgressHUD.show()
        self.navigationItem.searchController = searchBarController
        self.searchBarController.searchBar.delegate = self
        self.searchBarController.searchBar.placeholder = "Buscar"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if searchBarController.searchBar.text == ""{
            viewModel.getEmployeesList()
        }
        
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
            strongSelf.emplooyesToShow = strongSelf.emplooyes
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.employeesFilteredListRes = { [weak self] response in
            guard let strongSelf = self else {return}
            strongSelf.emplooyes = response
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
        
        viewModel.deleteEmployeeRes = {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
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
        
        if let employee = emplooyesToShow?[indexPath.row]{
            vc.employee = employee
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, handler) in
            
            if let employee = self.emplooyes?[indexPath.row] {
                SVProgressHUD.show()
                self.viewModel.deleteEmployee(employee: employee)
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emplooyesToShow?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as? EmplooyeTableViewCell
        cell?.labelName.text = emplooyesToShow?[indexPath.row].name
        cell?.labelPosition.text = emplooyesToShow?[indexPath.row].position
        return cell ?? UITableViewCell()
    }
    
    
}


extension ViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        viewModel.getEmployeesList()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            viewModel.getEmployeesList()
        }else{
            let filteredEmployees = emplooyes?.filter{ ($0.name?.contains(searchText ))!}
            emplooyesToShow = filteredEmployees
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarController.isActive = false
    }
}

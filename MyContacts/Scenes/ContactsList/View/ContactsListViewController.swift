//
//  MasterViewController.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class ContactsListViewController: UITableViewController {
    
    var presenter: ContactsListPresenterProtocol?
    
    var detailViewController: ContactDetailsViewController? = nil
    var groupedContacts = [ContactsListSectionViewModel]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ContactsListRouter.createContactListModule(with: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ContactsListRouter.createContactListModule(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ContactDetailsViewController
        }
        
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {

    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //let object = contacts[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! ContactDetailsViewController
                //controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedContacts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedContacts[section].contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as? ContactTableViewCell
        let contactCellViewModel = groupedContacts[indexPath.section].contacts[indexPath.row]
        cell?.configure(with: contactCellViewModel)
        return cell ?? ContactTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactViewModel = groupedContacts[indexPath.section].contacts[indexPath.row]
        presenter?.showDetails(forContact: contactViewModel.id)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupedContacts.map({ $0.title })
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedContacts[section].title
    }
}

extension ContactsListViewController : ContactsListViewProtocol {
    
    func showContacts(with sections: [ContactsListSectionViewModel]) {
        self.groupedContacts = sections
        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "An error occurred", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

//
//  DetailViewController.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: ContactDetailsPresenterProtocol?
    private var viewModel: ContactDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }
    
    private func editBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction(sender:)))
    }
    
    @objc private func editButtonAction(sender: UIBarButtonItem) {
        
    }
    
    private func doneBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(sender:)))
    }
    
    @objc private func doneButtonAction(sender: UIBarButtonItem) {
        
    }
    
    private func cancelBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction(sender:)))
    }
    
    @objc private func cancelButtonAction(sender: UIBarButtonItem) {
        
    }
}

extension ContactDetailsViewController : ContactDetailsViewProtocol {
    
    func showDetails(contactDetails: ContactDetailsViewModel) {
        self.viewModel = contactDetails
        tableView.reloadData()
    }
    
    func configureNavigationItems(leftNavigationItem: UIBarButtonItem.SystemItem?, rightNavigationItem: UIBarButtonItem.SystemItem) {
        navigationItem.leftBarButtonItem = nil
        if let _leftNavigationItem = leftNavigationItem {
            switch _leftNavigationItem {
            case .edit:
                navigationItem.leftBarButtonItem = editBarButtonItem()
            case .done:
                navigationItem.leftBarButtonItem = doneBarButtonItem()
            case .cancel:
                navigationItem.leftBarButtonItem = cancelBarButtonItem()
            default:
                break
            }
        }
        
        switch rightNavigationItem {
        case .edit:
            navigationItem.rightBarButtonItem = editBarButtonItem()
        case .done:
            navigationItem.rightBarButtonItem = doneBarButtonItem()
        case .cancel:
            navigationItem.rightBarButtonItem = cancelBarButtonItem()
        default:
            break
        }
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension ContactDetailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ContactDetailsSection(rawValue: indexPath.section)
        switch section {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsHeaderTableViewCell.reuseIdentifier) as? ContactDetailsHeaderTableViewCell
            headerCell?.configure(with: viewModel!.headerInfo)
            return headerCell ??  ContactDetailsHeaderTableViewCell()
        case .details:
            let formCell = tableView.dequeueReusableCell(withIdentifier: ContactFormTableViewCell.reuseIdentifier, for: indexPath) as? ContactFormTableViewCell
            formCell?.configure(with: viewModel!.formItems[indexPath.row])
            return formCell ?? ContactFormTableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension ContactDetailsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}


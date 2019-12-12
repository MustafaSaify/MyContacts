//
//  DetailViewController.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit
import MBProgressHUD

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: ContactDetailsPresenterProtocol?
    private var viewModel: ContactDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactDetailsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactDetailsViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func favoriteButtonAction(sender: Any?) {
        presenter?.markAsFavourite()
    }
    
    @IBAction func selectAvatarAction(sender: Any?) {
        presenter?.markAsFavourite()
    }
    
    private func editBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonAction(sender:)))
    }
    
    @objc private func editButtonAction(sender: UIBarButtonItem) {
        presenter?.editContact()
    }
    
    private func doneBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(sender:)))
    }
    
    @objc private func doneButtonAction(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        presenter?.saveContact()
    }
    
    private func cancelBarButtonItem() -> UIBarButtonItem {
        self.view.endEditing(true)
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction(sender:)))
    }
    
    @objc private func cancelButtonAction(sender: UIBarButtonItem) {
        presenter?.cancel()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            print("Notification: Keyboard will show")
            tableView.setBottomInset(to: keyboardHeight)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        print("Notification: Keyboard will hide")
        tableView.setBottomInset(to: 0.0)
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
        let alert = UIAlertController(title: "Error", message: "An error occurred", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

extension ContactDetailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ContactDetailsSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsHeaderTableViewCell.reuseIdentifier) as? ContactDetailsHeaderTableViewCell
            headerCell?.configure(with: viewModel.headerInfo)
            return headerCell ??  ContactDetailsHeaderTableViewCell()
        case .details:
            let formCell = tableView.dequeueReusableCell(withIdentifier: ContactFormTableViewCell.reuseIdentifier, for: indexPath) as? ContactFormTableViewCell
            formCell?.configure(with: viewModel.formItems[indexPath.row])
            formCell?.delegate = self
            return formCell ?? ContactFormTableViewCell()
        }
    }
}

extension ContactDetailsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}

extension ContactDetailsViewController : ContactFormTableViewCellDelegate {
    func contactFormCell(cell: ContactFormTableViewCell, didEnteredText text: String?) {
        guard let cellIndex = tableView.indexPath(for: cell)?.row else {
            return
        }
        let formItem = viewModel.formItems[cellIndex]
        presenter?.record(value: text, for: formItem)
    }
}

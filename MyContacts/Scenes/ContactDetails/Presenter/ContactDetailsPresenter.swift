//
//  ContactDetailsPresenter.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailsPresenter : ContactDetailsPresenterProtocol {
    
    var view: ContactDetailsViewProtocol?
    var interactor: ContactDetailsInteractorInputProtocol?
    var dataStore: ContactDetailsDataStoreProtocol?
    var wireFrame: ContactDetailsWireFrameProtocol?
    var imageDownloader: ImageAccess?
       
    func viewDidLoad() {
        let viewModel = ContactDetailsViewModel(with: dataStore?.displayedContactInfo, mode: dataStore?.routedContact != nil ? .view : .add)
        view?.showDetails(contactDetails: viewModel)
        
        if let contact = dataStore?.routedContact, let id = contact.id {
            interactor?.fetchDetails(for: id)
            view?.configureNavigationItems(leftNavigationItem: nil, rightNavigationItem: .edit)
        }
        else {
            view?.configureNavigationItems(leftNavigationItem: .cancel, rightNavigationItem: .done)
        }
    }
    
    func editContact() {
        let viewModel = ContactDetailsViewModel(with: dataStore!.displayedContactInfo, mode: .edit)
        view?.showDetails(contactDetails: viewModel)
        view?.configureNavigationItems(leftNavigationItem: .cancel, rightNavigationItem: .done)
    }
    
    func cancel() {
        let viewModel = ContactDetailsViewModel(with: dataStore?.routedContact, mode: .view)
        view?.showDetails(contactDetails: viewModel)
        view?.configureNavigationItems(leftNavigationItem: nil, rightNavigationItem: .edit)
    }
    
    func record(value: String?, for formItem: ContactDetailsViewModel.FormItem) {
        switch formItem.type {
        case .firstName:
            self.dataStore?.displayedContactInfo.first_name = value ?? ""
        case .lastName:
            self.dataStore?.displayedContactInfo.last_name = value ?? ""
        case .email:
            self.dataStore?.displayedContactInfo.email = value
        case .phone:
            self.dataStore?.displayedContactInfo.phone_number = value
        default:
            break
        }
    }
    
    func record(avatar: UIImage) {
        
    }
    
    func saveContact() {
        view?.showLoading()
        interactor?.update(contact: dataStore!.displayedContactInfo)
    }
}

extension ContactDetailsPresenter : ContactDetailsInteractorOutputProtocol {
    
    func didFetchedContactDetails(contact: Contact) {
        self.dataStore?.routedContact = contact
        let viewModel = ContactDetailsViewModel(with: contact, mode: .view)
        view?.showDetails(contactDetails: viewModel)
    }
    
    func didSubmittedContact() {
        view?.hideLoading()
    }
    
    func onError() {
        view?.showError()
    }
    
}

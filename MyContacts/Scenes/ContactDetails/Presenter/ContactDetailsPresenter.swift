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
    var dataPassing: ContactDetailsDataPassingProtocol?
       
    func viewDidLoad() {
        let viewModel = ContactDetailsViewModel(with: dataStore?.displayedContactInfo, mode: dataStore?.routedContact != nil ? .view : .add)
        view?.showDetails(contactDetails: viewModel)
        
        if let contact = dataStore?.routedContact, let contactId = contact.id {
            view?.showLoading()
            interactor?.fetchDetails(for: contactId)
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
        if dataStore?.mode == .add {
            //Route to parent
            wireFrame?.routeToParent(from: view!)
        }
        else {
            let viewModel = ContactDetailsViewModel(with: dataStore?.routedContact, mode: .view)
            view?.showDetails(contactDetails: viewModel)
            view?.configureNavigationItems(leftNavigationItem: nil, rightNavigationItem: .edit)
        }
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
    
    func markAsFavourite() {
        let isFavourite = dataStore?.displayedContactInfo.favorite ?? false
        dataStore?.displayedContactInfo.favorite = !isFavourite
        saveContact()
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
        self.dataStore?.displayedContactInfo = contact
        let viewModel = ContactDetailsViewModel(with: contact, mode: .view)
        view?.showDetails(contactDetails: viewModel)
        view?.hideLoading()
    }
    
    func didSubmittedContact() {
        view?.hideLoading()
        if dataStore?.mode == .add {
            wireFrame?.routeToParent(from: view!)
            dataPassing?.didAddedNewContact()
        }
        else {
            //self.dataStore?.routedContact = dataStore?.displayedContactInfo
            let viewModel = ContactDetailsViewModel(with: dataStore?.displayedContactInfo, mode: .view)
            view?.showDetails(contactDetails: viewModel)
            view?.configureNavigationItems(leftNavigationItem: nil, rightNavigationItem: .edit)
            dataPassing?.didUpdatedContact(contact: dataStore?.displayedContactInfo)
        }
    }
    
    func onError() {
        view?.showError()
    }
    
}

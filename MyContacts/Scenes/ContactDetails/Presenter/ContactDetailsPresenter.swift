//
//  ContactDetailsPresenter.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactDetailsPresenter : ContactDetailsPresenterProtocol {
    
    var view: ContactDetailsViewProtocol?
    var interactor: ContactDetailsInteractorInputProtocol?
    var dataStore: ContactDetailsDataStoreProtocol?
    var wireFrame: ContactDetailsWireFrameProtocol?
    var imageDownloader: ImageAccess?
       
    func viewDidLoad() {
        //interactor?.retrieveContactsList()
        let viewModel = ContactDetailsViewModel(with: dataStore!.contact!)
        view?.showDetails(contactDetails: viewModel)
        
        if let _ = dataStore?.contact {
            view?.configureNavigationItems(leftNavigationItem: nil, rightNavigationItem: .edit)
        }
        else {
            view?.configureNavigationItems(leftNavigationItem: .cancel, rightNavigationItem: .done)
        }
    }
    
    func edit() {
        
    }
    
    func cancel() {
        
    }
    
    func done() {
        
    }
}

extension ContactDetailsPresenter : ContactDetailsInteractorOutputProtocol {
    
    func didUpdatedContact(_ contact: Contact) {
        
    }
    
    func didAddedContact(_ contact: Contact) {
        
    }
    
    func onError() {
        
    }
    
}

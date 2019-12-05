//
//  ContactsListPresenter.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class ContactsListPresenter : ContactsListPresenterProtocol {
    weak var view: ContactsListViewProtocol?
    var interactor: ContactsListInteractorInputProtocol?
    var dataStore: ContactsListDataStoreProtocol?
    var wireFrame: ContactsListWireFrameProtocol?
    var imageDownloader: ImageAccess?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveContactsList()
    }
    
    func showDetails(forContact contactId: Int) {
        guard let contact = dataStore?.contact(with: contactId) else {
            return
        }
        wireFrame?.routeToContactDetailsScreen(from: view!, for: contact)
    }

}

extension ContactsListPresenter: ContactsListInteractorOutputProtocol {
    
    func didRetrieveContacts(_ contacts: [Contact]) {
        view?.hideLoading()
        dataStore?.contacts = contacts
        let sections = sectionViewModels(from: contacts)
        view?.showContacts(with: sections)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}

extension ContactsListPresenter {
    
    func sectionViewModels(from contacts: [Contact]) -> [ContactsListSectionViewModel] {
        let groupedByFirst = Dictionary(grouping: contacts) { $0.first_name.uppercased().first! }
        let sections = groupedByFirst.map({ ContactsListSectionViewModel(title: $0.key.uppercased(),
                                                                         contacts: $0.value.map({ contactViewModel(from: $0) }))})
        return sections.sorted(by: { $0.title < $1.title })
    }
    
    func contactViewModel(from contact: Contact) -> ContactViewModel {
        return ContactViewModel(with: contact, imageDownloader: imageDownloader)
    }
}

//
//  ContactsListProtocols.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsListViewProtocol: class {
    var presenter: ContactsListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showContacts(with sections: [ContactsListSectionViewModel])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ContactsListWireFrameProtocol: class {
    static func createContactListModule(with view: ContactsListViewProtocol)
    // PRESENTER -> WIREFRAME
    func routeToContactDetailsScreen(from view: ContactsListViewProtocol, for contact: Contact)
    func routeToAddContactScreen(from view: ContactsListViewProtocol)
}

protocol ContactsListPresenterProtocol: class {
    var view: ContactsListViewProtocol? { get set }
    var interactor: ContactsListInteractorInputProtocol? { get set }
    var dataStore: ContactsListDataStoreProtocol? { get set }
    var wireFrame: ContactsListWireFrameProtocol? { get set }
    var imageDownloader: ImageAccess? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showDetails(forContact contactId: Int)
    func addNewContact()
}

protocol ContactsListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: [Contact])
    func onError()
}

protocol ContactsListInteractorInputProtocol: class {
    var presenter: ContactsListInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactsListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveContactsList()
}

protocol ContactsListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ContactsListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ContactsListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactsList()
}

protocol ContactsListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: [Contact])
    func onError()
}

protocol ContactsListDataStoreProtocol: class {
    var contacts: [Contact] { get set }
    
    // PRESENTER -> DATASTORE
    func contact(with id: Int) -> Contact?
}

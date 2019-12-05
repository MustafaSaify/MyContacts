//
//  ContactDetailsProtocols.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailsViewProtocol: class {
    var presenter: ContactDetailsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showDetails(contactDetails: ContactDetailsViewModel)
    
    func configureNavigationItems(leftNavigationItem: UIBarButtonItem.SystemItem?, rightNavigationItem: UIBarButtonItem.SystemItem)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ContactDetailsWireFrameProtocol: class {
    static func createContactDetailsModule(for contact: Contact?) -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentEditContactsDetailScreen(from view: ContactDetailsViewProtocol, forContact contact: Contact)
}

protocol ContactDetailsPresenterProtocol: class {
    var view: ContactDetailsViewProtocol? { get set }
    var interactor: ContactDetailsInteractorInputProtocol? { get set }
    var dataStore: ContactDetailsDataStoreProtocol? { get set }
    var wireFrame: ContactDetailsWireFrameProtocol? { get set }
    var imageDownloader: ImageAccess? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func edit()
    func cancel()
    func done()
}

protocol ContactDetailsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didUpdatedContact(_ contact: Contact)
    func didAddedContact(_ contact: Contact)
    func onError()
}

protocol ContactDetailsInteractorInputProtocol: class {
    var presenter: ContactDetailsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactDetailsRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func update(contact: Contact)
}

protocol ContactDetailsDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ContactDetailsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ContactDetailsRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactsList()
}

protocol ContactDetailsRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUpdateContact(_ contact: Contact)
    func onAddingNewContact(_ contact: Contact)
    func onError()
}

protocol ContactDetailsDataStoreProtocol {
    var contact: Contact? { get set }
}

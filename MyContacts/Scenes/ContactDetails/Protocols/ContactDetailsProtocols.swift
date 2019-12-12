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
    func openImagePicker(source: Any)
    func routeToParent(from view: ContactDetailsViewProtocol)
}

protocol ContactDetailsPresenterProtocol: class {
    var view: ContactDetailsViewProtocol? { get set }
    var interactor: ContactDetailsInteractorInputProtocol? { get set }
    var dataStore: ContactDetailsDataStoreProtocol? { get set }
    var wireFrame: ContactDetailsWireFrameProtocol? { get set }
    var imageDownloader: ImageAccess? { get set }
    var dataPassing: ContactDetailsDataPassingProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func editContact()
    func record(value: String?, for formItem: ContactDetailsViewModel.FormItem)
    func presentImagePicker()
    func record(avatar: UIImage)
    func markAsFavourite()
    func saveContact()
    func cancel()
}

protocol ContactDetailsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didFetchedContactDetails(contact: Contact)
    func didSubmittedContact()
    func onError()
}

protocol ContactDetailsInteractorInputProtocol: class {
    var presenter: ContactDetailsInteractorOutputProtocol? { get set }
    var remoteDatamanager: ContactDetailsRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchDetails(for contactId: Int)
    func update(contact: Contact)
}

protocol ContactDetailsDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ContactDetailsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ContactDetailsRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func fetchDetails(for contactId: Int)
    func post(contact: Contact)
}

protocol ContactDetailsRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onFetchingContactDetails(contact: Contact)
    func onPostContactSuccess()
    func onError()
}

protocol ContactDetailsDataStoreProtocol {
    var mode: ContactDetailsSceneMode { get set }
    var routedContact: Contact? { get set }
    var displayedContactInfo: Contact { get set }
}

protocol ContactDetailsDataPassingProtocol {
    func didAddedNewContact()
    func didUpdatedContact(contact: Contact?)
}

//
//  ContactsListRouter.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/1/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class ContactsListRouter: ContactsListWireFrameProtocol {
    
    static func createContactListModule(with viewController: ContactsListViewProtocol) {
        
        let presenter: ContactsListPresenterProtocol & ContactsListInteractorOutputProtocol = ContactsListPresenter()
        let interactor: ContactsListInteractorInputProtocol & ContactsListRemoteDataManagerOutputProtocol = ContactsListInteractor()
        let remoteDataManager: ContactsListRemoteDataManagerInputProtocol = ContactsListRemoteDataManager(dataSource: ContactsListRemoteDataSource(baseURL: Enviornment.prod.host))
        let dataStore = ContactsListDataStore()
        let wireFrame: ContactsListWireFrameProtocol = ContactsListRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.dataStore = dataStore
        presenter.imageDownloader = NetworkImageAccess()
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
    }
    
    func routeToContactDetailsScreen(from view: ContactsListViewProtocol, for contact: Contact) {
        let contactDetailsViewController = ContactDetailsRouter.createContactDetailsModule(for: contact)
        (contactDetailsViewController as? ContactDetailsViewProtocol)?.presenter?.dataPassing = view.presenter as? ContactDetailsDataPassingProtocol
        if let sourceViewController = view as? UIViewController {
            if let splitViewController = sourceViewController.splitViewController {
                let navigationController = UINavigationController(rootViewController: contactDetailsViewController)
                splitViewController.showDetailViewController(navigationController, sender: nil)
            }
            else {
                sourceViewController.navigationController?.pushViewController(contactDetailsViewController, animated: true)
            }
        }
     }
    
    
    func routeToAddContactScreen(from view: ContactsListViewProtocol) {
        let addContactViewController = ContactDetailsRouter.createContactDetailsModule(for: nil)
        let navigationController = UINavigationController(rootViewController: addContactViewController)
         if let sourceView = view as? UIViewController {
            sourceView.present(navigationController, animated: true, completion: nil)
         }
     }
}

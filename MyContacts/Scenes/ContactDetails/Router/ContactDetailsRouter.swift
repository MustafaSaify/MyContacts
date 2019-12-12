//
//  ContactDetailsRouter.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/4/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailsRouter : ContactDetailsWireFrameProtocol {
    
    static func createContactDetailsModule(for contact: Contact?) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactDetailsViewController")
        guard let view = viewController as? ContactDetailsViewProtocol else {
            return UIViewController()
        }
        let presenter: ContactDetailsPresenterProtocol & ContactDetailsInteractorOutputProtocol = ContactDetailsPresenter()
        let interactor: ContactDetailsInteractorInputProtocol & ContactDetailsRemoteDataManagerOutputProtocol = ContactDetailsIntearctor()
        let remoteDataManager = ContactDetailsRemoteDataManager(dataSource: ContactDetailsDataSyncer())
        let dataStore = ContactDetailsDataStore(with: contact)
        let wireFrame: ContactDetailsWireFrameProtocol = ContactDetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.dataStore = dataStore
        presenter.imageDownloader = NetworkImageAccess()
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        dataStore.mode = contact != nil ? .view : .add
        
        return viewController
    }
    
    func routeToParent(from view: ContactDetailsViewProtocol) {
        guard let viewController = view as? UIViewController else {
            return
        }
        if let _ = viewController.presentingViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
        else {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

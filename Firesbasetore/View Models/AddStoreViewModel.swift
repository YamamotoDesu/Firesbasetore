//
//  StoreViewModel.swift
//  FirebaseStoreApp
//
//  Created by 山本響 on 2021/05/30.
//

import Foundation

class AddStoreViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var name: String = ""
    var address: String = ""
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func save() {
        let store = Store(name: name, address: address)
        firestoreManager.saveTest(store: store) { result in
            switch result {
            case .success(let store):
                if Thread.isMainThread {
                    self.saved = store == nil ? false : true
                } else {
                    DispatchQueue.main.sync {
                        self.saved = store == nil ? false : true
                    }
                }
            case .failure(_):
                if Thread.isMainThread {
                    self.message = Constants.Messages.storeSavedFailure
                } else {
                    DispatchQueue.main.sync {
                        self.message = Constants.Messages.storeSavedFailure
                    }
                }
            }
        }
    }
}

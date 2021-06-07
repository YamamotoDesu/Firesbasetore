//
//  StoreItemListViewModel.swift
//  FirebaseStoreApp
//
//  Created by 山本響 on 2021/05/31.
//

import Foundation

struct StoreItemViewState {
    var name: String = ""
    var price: String = ""
    var quantity: String = ""
}

struct StoreItemViewModel {
    var storeItem: StoreItem
    
    var storeItemId: String {
        storeItem.id ?? ""
    }
    
    var name: String {
        storeItem.name
    }
    
    var price: Double {
        storeItem.price
    }
    
    var quantity: Int {
        storeItem.quantity
    }
}

class StoreItemListViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    var storeItemName: String = ""
    @Published var store: StoreViewModel?
    @Published var storeItems: [StoreItemViewModel] = []
    
    //var storeItemVS = StoreItemViewState()
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func getStoreItemBy(storeId: String) {
        
        firestoreManager.getStoreItemBy(storeId: storeId) { (result) in
            switch result {
            case .success(let items):
                if let items = items {
                    DispatchQueue.main.async {
                        self.storeItems = items.map(StoreItemViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteStoreItem(storeId: String, storeItemId: String) {
        firestoreManager.deleteStoreItem(storeId: storeId, storeItemId: storeItemId) { (error) in
            if error == nil {
                self.getStoreItemBy(storeId: storeId)
            }
        }
    }
    
    func getStoreById(storeId: String) {
        firestoreManager.getStoreById(storeId: storeId) { result in
            switch result {
            case .success(let store):
                if let store = store {
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: store)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addItemToStore(storeId: String, storeItemVS: StoreItemViewState, completion: @escaping (Error?) -> Void) {
        
        let storeItem = StoreItem.from(storeItemVS)
        firestoreManager.updateStore(storeId: storeId, storeItem: storeItem) { (result) in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}

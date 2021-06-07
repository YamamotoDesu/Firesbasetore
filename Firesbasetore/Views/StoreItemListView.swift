//
//  StoreItemListView.swift
//  FirebaseStoreApp
//
//  Created by 山本響 on 2021/05/31.
//

import SwiftUI

struct StoreItemListView: View {
    
    var store: StoreViewModel
    @StateObject private var storeItemListVM = StoreItemListViewModel()
    @State private var storeItemVS = StoreItemViewState()
    
    func delteStoreItem(at indexSet: IndexSet) {
        indexSet.forEach { (index) in
            let storeItem = storeItemListVM.storeItems[index]
            storeItemListVM.deleteStoreItem(storeId: store.storeId, storeItemId: storeItem.storeItemId)
        }
    }
    
    var body: some View {
        VStack {
            TextField("商品を入力して下さい。", text: $storeItemVS.name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            TextField("金額を入力して下さい。", text: $storeItemVS.price).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            TextField("商品数を入力して下さい。", text: $storeItemVS.quantity).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        
            Button("登録") {
                storeItemListVM.addItemToStore(storeId: store.storeId, storeItemVS: storeItemVS) { (error) in
                    
                    if error == nil {
                        storeItemVS = StoreItemViewState()
                        storeItemListVM.getStoreItemBy(storeId: store.storeId)
                    }
                }
            }
            
            List {
                ForEach(storeItemListVM.storeItems, id: \.storeItemId) { storeItem in
                    Text(storeItem.name)
                }.onDelete(perform: delteStoreItem)
            }
            
            Spacer()
            
            .onAppear(perform: {
                storeItemListVM.getStoreItemBy(storeId: store.storeId)
            })
        }
    }
}

struct StoreItemListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemListView(store: StoreViewModel(store: Store(id: "123", name: "セブンイレブン", address: "赤坂", items: nil)))
    }
}

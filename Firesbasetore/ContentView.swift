//
//  SceneDelegate.swift
//  Firesbasetore
//
//  Created by 山本響 on 2021/06/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @ObservedObject private var storeListVM = StoreListViewModel()
    
    var body: some View {
        VStack {
            List(storeListVM.stores, id:\.storeId) { store in
                NavigationLink(
                    destination: StoreItemListView(store: store),
                    label: {
                        StoreCell(store: store)
                    })
            }.listStyle(PlainListStyle())
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            storeListVM.getAll()
        }, content: {
            AddStoreView()
        })
        
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        
        .navigationTitle("Firebase Store")
        .embedInNavigationView()
        
        .onAppear(perform: {
            storeListVM.getAll()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StoreCell: View {
    
    var store: StoreViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(store.name)
                .font(.headline)
            Text(store.address)
                .font(.body)
        }
        .listStyle(PlainListStyle())
    }
}

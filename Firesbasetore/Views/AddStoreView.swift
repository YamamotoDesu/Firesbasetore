//
//  AddStoreView.swift
//  FirebaseStoreApp
//
//  Created by 山本響 on 2021/05/30.
//

import SwiftUI

struct AddStoreView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addStoreVM = AddStoreViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("店舗名", text: $addStoreVM.name)
                TextField("住所", text: $addStoreVM.address)
                HStack {
                    Spacer()
                    Button("追加") {
                        addStoreVM.save()
                    }
                    .onChange(of: addStoreVM.saved, perform: { saved in
                        if saved {
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
                    Spacer()
                }
                
                Text(addStoreVM.message)
                
            }
        }.navigationBarItems(leading: Button(action: {
            presentationMode
                .wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        }))
        .navigationTitle("店舗を追加する")
        .embedInNavigationView()
    }
}

struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView()
    }
}

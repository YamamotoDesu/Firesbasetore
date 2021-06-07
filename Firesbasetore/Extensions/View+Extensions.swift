//
//  View+Extensions.swift
//  FirebaseStoreApp
//
//  Created by Mohammad Azam on 10/23/20.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}

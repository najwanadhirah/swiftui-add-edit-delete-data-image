//
//  bookstoreApp.swift
//  bookstore
//
//  Created by Najwa Nadhirah on 04/10/2021.
//

import SwiftUI

@main
struct Book_StoreApp: App {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) var moc
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false

    var body: some Scene {
        WindowGroup {
                loginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
       }
    }
}

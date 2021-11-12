//
//  ContentView.swift
//  bookstore
//
//  Created by Najwa Nadhirah on 04/10/2021.
//

import SwiftUI
import CoreData

let persistenceController = PersistenceController.shared

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Saving.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Saving.name, ascending: true),
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Saving.desc, ascending: true),
        NSSortDescriptor(keyPath: \Saving.author, ascending: true),
    ]
    )
    
    var savings : FetchedResults<Saving>
                    
    @State var image : Data = .init(count: 0)
    @State var show = false
    
    func removeRows(at offsets: IndexSet) {
        for index in offsets {
            let save = savings[index]
            moc.delete(save)
        }
    }
    
    
    var body: some View {
        VStack{
   
                List{
                        ForEach(savings, id:\.self) { save in
                            NavigationLink(destination: BookDetailsView(save:save)){
                                
                                HStack{
                                    if (save.imageD != self.image){
                                    Image(uiImage:  UIImage(data: save.imageD ?? self.image)!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                    }
                                    
                                    else{
                                        Image(systemName: "photo.fill")
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(8)
                                    }
                                    VStack(spacing:3){
                                        Text("\(save.name ?? "")")
                                             .font(.system(size: 18, weight:  .bold))
                                        Text("\(save.author ?? "")")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight:  .semibold))
                                        Text("\(save.desc ?? "")")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, weight:  .semibold))
                                    }
                                }
                                
                            }
                      
                        }.onDelete(perform: removeRows)
                    }
                }
    
       .edgesIgnoringSafeArea(.all)
       .navigationBarTitle("project name", displayMode: .inline)
        .navigationBarItems(
            leading:
                   HStack {
                       Button(action: {}) {
                           NavigationLink(destination: loginView().navigationBarBackButtonHidden(true)) {
                               Text("logout")
                                        .bold()
                                        .frame(width: 70, height: 40)
                                        .background(Color.orange)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                  }
                            }
                   },
            trailing:
                   HStack {
                       Button(action: {
                           self.show.toggle()
                       }) {
                           Image(systemName: "plus")
                       }
                   }
                .fullScreenCover(isPresented: self.$show) {
                    addDataView().environment(\.managedObjectContext,self.moc )
                       }
                )
        }
            
   }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
           ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

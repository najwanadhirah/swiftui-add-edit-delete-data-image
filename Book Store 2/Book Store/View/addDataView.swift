//
//  addDataView.swift
//  bookstore
//
//  Created by Najwa Nadhirah on 08/10/2021.
//

import SwiftUI


struct addDataView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var image : Data = .init(count: 0)
    @State var show = false
    @State var name = ""
    @State var author = ""
    @State var desc = ""
    @State var selection: Int? = nil
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                  if self.image.count != 0 {
                      Button(action:{
                          self.show.toggle()
                      }){
                      Image(uiImage: UIImage(data: self.image)!)
                              .renderingMode(.original)
                              .resizable()
                              .frame(width: 100, height: 100)
                              .cornerRadius(6)
                      }
              }
                  else{
                      Button(action:{
                          self.show.toggle()
                      })
                      {
                      Image(systemName: "photo.fill")
                          .font(.system(size: 55))
                          .foregroundColor(.gray)
                      }
                  }
                  TextField("Name",text: $name)
                      .padding()
                      .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                      .cornerRadius(24)
                  
                  TextField("Author",text: $author)
                    .padding()
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(24)
                
                  TextField("Description",text: $desc)
                    .padding()
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(24)
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), tag: 1, selection: $selection){
                Button(action: {
                    let save = Saving(context: self.moc)
                    save.name = self.name
                    save.author = self.author
                    save.desc = self.desc
                    save.imageD = self.image
                    self.selection = 1
                    try? self.moc.save()
                }){Text("save")
                        .fixedSize()
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical,20)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.opacity(0.9))
                        .cornerRadius(40.0)
                    }
                }
              }.sheet(isPresented: self.$show, content: {
                  ImagePicker(show: self.$show, image: self.$image)})
                .navigationBarTitle(Text("add"))
          }
    }
}


struct addDataView_Previews: PreviewProvider {
    static var previews: some View {
        addDataView().environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

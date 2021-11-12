//
//  BookDetailsView.swift
//  bookstore
//
//  Created by Najwa Nadhirah on 09/10/2021.
//

import SwiftUI
import ToastUI


struct BookDetailsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.managedObjectContext) var moc
    @State private var showingAlert = false
    
    let save: Saving
    
    @State var newName: String = ""
    @State  var newAuthor: String = ""
    @State  var newDesc: String = ""
    @State var image : Data = .init(count: 0)
    @State var selection: Int? = nil
    @State private var presentingToast: Bool = false
    @State var show = false
    
    @State var showDetail: Bool = false
    
    init(save: Saving) {
        self.save = save
      self._newName = State(initialValue: save.name ?? "")
        self._newAuthor = State(initialValue: save.author ?? "")
        self._newDesc = State(initialValue: save.desc ?? "")
        self._image = State(initialValue: save.imageD ?? self.image)
      // etc.
    }
    
    var body: some View {
        VStack(spacing:20) {
                    if self.image.count != 0 {
                    Button(action:{
                        self.show.toggle()
                    })
                    {
                        Image(uiImage:
                                UIImage(data:self.image)!)
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
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(6)
                        }
                    }
                        TextField(save.name ?? "", text: $newName)
                            .padding()
                            .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                            .cornerRadius(24)
                    
                        TextField(save.author ?? "", text: $newAuthor)
                            .padding()
                            .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                            .cornerRadius(24)
                    
                        TextField(save.desc ?? "", text: $newDesc)
                            .padding()
                            .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                            .cornerRadius(24)
                }
                .sheet(isPresented: self.$show, content: {
                  ImagePicker(show: self.$show, image: self.$image)  })
        
        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),
                       tag: 1, selection: $selection){
                
                Button(action: {
                    save.name = newName
                    save.author = newAuthor
                    save.desc = newDesc
                    save.imageD = self.image
                    showingAlert = true
                    self.selection = 1
                    try? self.moc.save()
                }){Text("Update")
                        .fixedSize()
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical,20)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.opacity(0.9))
                        .cornerRadius(40.0)
                }
                .alert(isPresented:$showingAlert) {
                           Alert(
                               title: Text("bookupdate")
                           )}
            }
         }
    }


//struct BookDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//       BookDetailsView(moc: <#T##Environment<NSManagedObjectContext>#>, save: <#T##Saving#>, newName: <#T##String#>, newAuthor: <#T##String#>, newDesc: <#T##String#>, image: <#T##Data#>, show: <#T##Bool#>)
//      //  BookDetailsView()
//    }
//}

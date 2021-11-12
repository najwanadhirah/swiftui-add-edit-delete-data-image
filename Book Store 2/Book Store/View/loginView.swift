//
//  login.swift
//  bookstore
//
//  Created by Najwa Nadhirah on 04/10/2021.
//

import SwiftUI
import CoreData

let storedUsername = "SS"
let storedpassword = "11111"


struct loginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView{
        VStack(spacing:20){
            Spacer()
                Text("project name")
                    .font(.system(size: 50, weight:  .semibold))
                    .foregroundColor(.white)
                    .padding()
            
                Text("welcome")
                    .font(.system(size: 20, weight:  .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Username", text: $username)
                    }.frame(height: 60)
                        .padding(.horizontal,20)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal,20)
                HStack{
                Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("password", text: $password)
                }.frame(height:60)
                    .padding(.horizontal,20)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal,20)

            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), tag: 1, selection: $selection){
            Button(action: {
                if self.username == storedUsername && self.password == storedpassword {
                    self.selection = 1
                    self.authenticationDidSucceed = true
                    self.authenticationDidFail = false
                }
                else {
                    self.authenticationDidFail = true
                    self.authenticationDidSucceed = false
                    }
                })
                {
                    LoginButtonContent()
                }
            }
            .padding(.horizontal,20)
            
        if authenticationDidSucceed {
            Text("success")
                .background(Color.black)
                .foregroundColor(.orange)
        }
            
        if authenticationDidFail {
            Text("failed")
                .background(Color.black)
                .foregroundColor(.orange)
        }
            Spacer()
            Spacer()
            }
        .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode:.fill)
            ).edgesIgnoringSafeArea(.all)
      }
    }
}


struct loginView_Previews: PreviewProvider {
    static var previews: some View {
            loginView() .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

struct LoginButtonContent: View {
    var body: some View {
       
        Text("login")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical,20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.orange.opacity(0.9))
            .cornerRadius(40.0)
    }
}


//
//  LoginView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 01/09/23.
//

import SwiftUI

struct LoginView: View {
    @State var number = ""
    @State var password = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    
    @State private var isAuthenticating = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userNumber") var userNumber: String = ""
    @AppStorage("userPassword") var userPassword: String = ""

    
    @State private var showChatView = false
    
    let domain = "uatchat2.waafi.com"
    
    private func authenticateUser() {
        isAuthenticating = true
        let userJID = "\(number)@\(domain)"
        XMPPService.shared.connect(hostName: domain, port: 5222, username: userJID, password: password) { success, error in
            DispatchQueue.main.async {
                self.isAuthenticating = false
                if success {
                    // Store current user in AppStorage
                    self.isLoggedIn = true
                    self.userNumber = self.number
                    self.userPassword = self.password
                    
                    self.errorMessage = nil
                    self.successMessage = "Welcome \(self.number)"
                } else {
                    switch error {
                    case .wrongUserJID:
                        self.errorMessage = "Invalid JID"
                    case .failedToConnect:
                        self.errorMessage = "Failed to connect. Please try again."
                        XMPPService.shared.disconnect()
                    case .authenticationFailed:
                        self.errorMessage = "Authentication failed. Check your number and password."
                        XMPPService.shared.disconnect()
                    default:
                        self.errorMessage = "An unknown error occurred. Please try again."
                        XMPPService.shared.disconnect()
                    }
                }
            }
        }
    }
    
    var body: some View
        {
            NavigationView {
                VStack {
                    HStack {
                        Spacer(minLength: 0)
                        
                        Image("waafi_logo")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing)
                            .frame(width: 200, height: 200)
                        
                        Spacer(minLength: 0)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("Join our app, enjoy chatting with your friends & family")
                        .font(.system(size: 25, weight: .heavy, design: .default))
                        .frame(width: (getRect().width * 0.9 ), alignment: .center)
                        .foregroundColor(Color("text"))
                        .padding(50)

                    
                    if let successMessage = successMessage {
                        Text(successMessage)
                            .foregroundColor(Color.green)
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(Color.red)
                    }

                    Spacer(minLength: 0)
                    
                    VStack (alignment: .center, spacing: 5) {
                        HStack {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "phone.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("ColorGreenMedium"))
                                .padding(.horizontal, 30)
                            
                            CustomAuthTextField(placeHolder: "90-xxxx-xxxx-xx", text: $number)
                            
                            Spacer(minLength: 0)
                            
                        }.overlay {
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        }
                        .padding()
                    
                        HStack {
                            Spacer(minLength: 0)
                            
                            Image(systemName: "lock.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("ColorGreenMedium"))
                                .padding(.horizontal, 30)
                            
                            SecureAuthTextField(placeHolder: "******", text: $password)
                            
                            Spacer(minLength: 0)
                            
                        }.overlay {
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        }
                        .padding()
                        
                        

                    
                        Button(action: {
                            authenticateUser()
                                  }, label: {
                                      RoundedRectangle(cornerRadius: 36)
                                          .foregroundColor(Color("ColorGreenMedium"))
                                          .frame(width: 320, height: 60, alignment: .center)
                                          .overlay {
                                              Text(isAuthenticating ? "Logging in..." : "Login")
                                                  .fontWeight(.bold)
                                                  .font(.title3)
                                                  .foregroundColor(Color.white)
                                                  .padding()
                                          }
                                  })
                                  .disabled(isAuthenticating)
                        
                    }
                    .padding()
                    
                    VStack (alignment: .center) {
                        VStack {
                            Text("By Signing up, you agree to our ")
                            + Text("Terms")
                                .foregroundColor(Color("text"))
                            + Text(", ")
                            + Text("Privacy Policy")
                                .foregroundColor(Color("text"))
                            + Text(", Cookie Use")
                                .foregroundColor(Color("text"))
                        }
                        .padding()
                        .frame(width: (getRect().width * 0.9 ), alignment: .center)
                        
                        
                        
                    }
                }
                .navigationBarHidden(true)
                .navigationBarTitle("")
            }
        }
}


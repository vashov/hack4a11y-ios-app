//
//  SignUpView.swift
//  Objectiver
//
//  Created by Борис Вашов on 10.10.2021.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SignUpViewModel()

    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack {
                
                LogoView()
                    .padding(.top, 50)
                
                if viewModel.roleSelected == nil {
                    Spacer(minLength: 0)
                    
                    Button(action: { viewModel.roleSelected = 1 } ) {
                        Text("I am volunteer")
                            .foregroundColor(Color.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 22)
                    
                    Button(action: { viewModel.roleSelected = 0 } ) {
                        Text("I need some help")
                            .foregroundColor(Color.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 22)
                }
                else {
                    VStack(spacing: 20) {
                        CustomTextField(image: "person", placeHolder: "Phone number", txt: $viewModel.login)
                        CustomTextField(image: "lock", placeHolder: "Password", isSecurityField: true, txt: $viewModel.password)
                        CustomTextField(
                            image: "lock",
                            placeHolder: "Password confirm",
                            isSecurityField: true,
                            txt: $viewModel.passwordRepeat)
                    }
                    .padding(.top)

                    Button(action: { viewModel.registrationRequest(
                            successCallback: {
                                DispatchQueue.main.async {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }) }
                    ) {
                        Text("SIGN UP")
                            .foregroundColor(Color.foregroundSecond)
                            .bold()
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.backgroundSecond)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 22)
                    .disabled(!viewModel.isValidForm)
                }
                

                HStack {
                    Text("Have an account?")
                        .foregroundColor(Color.foregroundThird.opacity(0.5))

                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Text("Sign In")
                            .foregroundColor(Color.foregroundPrimary)
                    }
                }
                .padding(.top, 22)

                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .background(Color.backgroundPrimary)
//            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//
//  LoginViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 13.10.2021.
//

import Foundation
import Swinject

class LoginViewModel: ObservableObject {

    @Inject
    var authRepository: AuthRepository
    
    @Inject
    var appState: AppState
    
    @Published var login = ""
    @Published var password = ""
    @Published var showSignUp = false
    @Published var isLoading = false

    var isValidForm: Bool {
        let check = isValidLogin() && isValidPassword()
        print(check)
        return check
    }

    private func isValidLogin() -> Bool {
        PhoneValidator.isValid(login)
    }

    private func isValidPassword() -> Bool {
        PasswordValidator.isValid(password)
    }

    func loginRequest() {
        if !isValidForm {
            return
        }

        self.isLoading = true

        authRepository.login(login, password) { res in
            switch res {
            case .success(let tokenResult):
                if !tokenResult.accessToken.isEmpty {
                    self.appState.signIn(
                        token: tokenResult.accessToken,
                        userId: tokenResult.userId,
                        roles: tokenResult.roles)
                }
                print(tokenResult.accessToken)
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

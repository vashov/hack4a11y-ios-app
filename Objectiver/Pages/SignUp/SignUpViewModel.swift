//
//  SignUpViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 13.10.2021.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Inject
    var authRepository: AuthRepository
    
    @Published var roleSelected: Int?
    @Published var login = ""
    @Published var password = ""
    @Published var passwordRepeat = ""
    
    @Published var isLoading = false

    var isValidForm: Bool {
        let check = isValidLogin() && isValidPassword() && password == passwordRepeat
        print(check)
        return check
    }

    private func isValidLogin() -> Bool {
        PhoneValidator.isValid(login)
    }

    private func isValidPassword() -> Bool {
        PasswordValidator.isValid(password)
    }

    func registrationRequest(successCallback: @escaping () -> Void) {
        if !isValidForm {
            return
        }

        isLoading = true

        authRepository.register(login, password, roleSelected!) { res in
            switch res {
            case .success(let registrationResult):
                print(registrationResult)
                if registrationResult {
                    successCallback()
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

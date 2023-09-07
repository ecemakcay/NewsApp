//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    
    func register(email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    // login
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                }
            }
        } else {
            // Missing fields
            let error = NSError(domain: "RegistrationError", code:0)
            completion(.failure(error))
        }
    }

    
}

//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel{
    
    func login(email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } else {
            // Missing fields
            let error = NSError(domain: "LoginError", code:0)
            completion(.failure(error))
        }
    }
}

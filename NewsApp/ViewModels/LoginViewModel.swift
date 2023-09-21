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
    func getUser() -> String{
        let user = Auth.auth().currentUser
        return user?.email ?? ""
    }
    
    func logout() -> Bool{
        let islogin : Bool = true
       
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
                return false
            }
        return islogin
    }
    
}

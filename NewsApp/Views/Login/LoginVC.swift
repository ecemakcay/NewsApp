//
//  LoginVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import UIKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        
    }
    
    
    @IBAction func loginBtnAct(_ sender: Any) {
        loginViewModel.login(email: emailTextField.text, password: passwordTextField.text) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.navigateHomePage()
                   
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func navigateHomePage(){
        let storyboard = UIStoryboard(name: "HomePageVC", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "HomePageVC") as? HomePageVC {
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            navigationController?.pushViewController(controller, animated: true)
            navigationController!.isNavigationBarHidden = true
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

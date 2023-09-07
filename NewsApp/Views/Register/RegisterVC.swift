//
//  RegisterVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import UIKit

class RegisterVC: UIViewController{
    
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    let registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    
    @IBAction func registerBtnAct(_ sender: Any) {
        registerViewModel.register(email: emailLabel.text, password: passwordLabel.text) { result in
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

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func haveAccountBtnAct(_ sender: Any) {
        self.navigateLoginPage()
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
    
    func navigateLoginPage(){
        let storyboard = UIStoryboard(name: "LoginVC", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

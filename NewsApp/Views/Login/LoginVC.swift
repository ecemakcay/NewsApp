//
//  LoginVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import UIKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        setUpBtn()
        setUpTitleView()
    }
    
    func setUpBtn(){
        loginBtn.layer.cornerRadius = 15
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func setUpTitleView(){
        titleView.layer.cornerRadius = 30
        titleView.layer.borderWidth = 1
        titleView.layer.borderColor = UIColor.black.cgColor
//        titleView.alpha = 0.7
        
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
    
    func navigateHomePage() {

        let storyboard = UIStoryboard(name: "HomePageVC", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyTabbarController") as? MyTabbarController {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            present(vc, animated: true)
        }


    }

    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

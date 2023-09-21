//
//  ProfilePageVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 8.09.2023.
//

import UIKit

class ProfilePageVC: UIViewController {

    @IBOutlet weak var profilView: UIView!
    @IBOutlet weak var signOutBtn: UIButton!
    let viewModel = LoginViewModel()

    @IBOutlet weak var emailLayer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        viewSetUp()
        getEmail()
    }
    
    func viewSetUp(){
        signOutBtn.layer.cornerRadius = 15
        profilView.layer.cornerRadius = 40
    }
    func getEmail(){
        let email = viewModel.getUser()
        emailLayer.text = email
    }

    @IBAction func signOutBtnAct(_ sender: Any) {
        if viewModel.logout() {
            navigateToLoginScreen()
        } else {
            
            showAlert(message: "An error occurred while logging out.")
        }
    }

    private func navigateToLoginScreen() {
        let storyboard = UIStoryboard(name: "RegisterVC", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            present(vc, animated: true)
            
           
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

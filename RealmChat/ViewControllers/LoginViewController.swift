//
//  LoginViewController.swift
//  RealmChat
//
//  Created by Håkon Knutzen on 29/01/2017.
//  Copyright © 2017 Håkon Knutzen. All rights reserved.
//

import Foundation
import UIKit


final class LoginViewController: UIViewController{
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var authenticationHostTextField: UITextField!
    
    @IBAction private func tappedCancel(_ _: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setUserInteraction(enabled: Bool){
        navigationController?.navigationBar.isUserInteractionEnabled = enabled
        view.subviews.forEach{
            $0.isUserInteractionEnabled = enabled
        }
    }
    
    private func login(register: Bool){
        setUserInteraction(enabled: false)
        let helper = LoginHelper(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", register: register)
        helper.authenticate(authHost: authenticationHostTextField.text ?? "") { [weak self] user, error in
            guard let strongSelf = self else { return }
            strongSelf.setUserInteraction(enabled: true)
            if let error = error {
                strongSelf.display(message: error.improvedError)
            } else {
                guard let user = user else { return }
                strongSelf.display(message: "Logged in with user: \(user.identity)")
            }
        }
    }
    
    private func display(message: String){
        let controller = UIAlertController(title: "Login:", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction private func tappedLogin(_ _: Any) {
        login(register: false)
    }
    @IBAction private func tappedRegister(_ sender: Any) {
        login(register: true)
    }
}

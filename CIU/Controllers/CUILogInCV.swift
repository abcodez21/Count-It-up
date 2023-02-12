//
//  ViewController.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 1/14/23.
//

import UIKit
import FirebaseAuth

class CUILogInCV: UIViewController {

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var loginBG: UIView!
    @IBOutlet var inputs: [UITextField]!
    @IBOutlet var buttons: [UIButton]!
    var count = 0
    let centeredParagraphStyle = NSMutableParagraphStyle()
    
    
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    override func viewDidLoad() {
       
        centeredParagraphStyle.alignment = .center
        super.viewDidLoad()
        loginBG.layer.cornerRadius = 40
        errorLabel.isHidden = true
        for button in buttons {
            button.layer.cornerRadius = 15
        }
        
        editInputs()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        let email = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if !isFieldEmpty(){Auth.auth().signIn(withEmail: email, password: password){
            (result, error) in
            

            if error != nil {
                print(error!.localizedDescription)
                self.errorLabel.isHidden = false
                self.errorLabel.text = error!.localizedDescription
            }
            else{
                self.errorLabel.isHidden = true
                self.performSegue(withIdentifier: C.LogInSegue, sender: self)
                print("successful")
                }
            
            }
            
        }

    }
    
    
    func editInputs(){
        
        
        for input in inputs{
            var statement: String
            
            switch count{
                case 0: statement = "type your email"
                case 1: statement = "type your password"
            default:
                statement = "none"
            }
            
            input.layer.cornerRadius = 15
            input.attributedPlaceholder = NSAttributedString(
                string: statement, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBackground, .paragraphStyle: centeredParagraphStyle]
            )
            
            count+=1
        }
    }
    
    
    func isFieldEmpty() -> Bool{
        for input in inputs{
            
            if input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                
                input.attributedPlaceholder = NSAttributedString(
                    string: "please fill in all fields", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed, .paragraphStyle: centeredParagraphStyle]
                )
                
                return true
            }
            
        }
        return false
    }


}


//
//  ForgetPasswordVC.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 2/1/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class ForgetPasswordVC: UIViewController {
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var background: UIView!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var inputs: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in buttons{
            button.layer.cornerRadius = 15
        }
        emailInput.layer.cornerRadius = 15
        background.layer.cornerRadius = 40
        errorLabel.isHidden = true
        
        
        emailInput.attributedPlaceholder = NSAttributedString(
            string: "Enter email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBackground, .paragraphStyle: Utilities.centeredParagraphStyle]
        )
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if !Utilities.isInputEmpty(inputs: inputs){
            let auth = Auth.auth()
            
            auth.sendPasswordReset(withEmail: emailInput.text!) { (error) in
                self.errorLabel.isHidden = false
                if error != nil {
                    self.errorLabel.text = error?.localizedDescription
                }else{
                    self.errorLabel.text = "A new password reset email has been sent!"
                }
            }
        }
            
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

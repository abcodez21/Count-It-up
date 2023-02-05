import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpVC: UIViewController {
    var count = 0
    @IBOutlet var signUpView: UIView!
    @IBOutlet var Inputs: [UITextField]!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        signUpView.layer.cornerRadius = 40
        for button in buttons{
            button.layer.cornerRadius = 15
        }
        editInputs()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //check fields & validate if data is correct
    func areFieldsValid() -> Bool{
        
        // check all field have data
        if Utilities.isInputEmpty(inputs: Inputs){
            return false
        }
        
        let cleanedPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // chekc if password follow rules of the password
        if  !Utilities.isPasswordValid(cleanedPassword){
            showError("Please make sure your password is atleast 8 characters contains 1 Alphabet and 1 Number")
            return false
        }
        
        return true
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        // validate field
        let error = areFieldsValid()
        if error{
            // ther is no errorr
            let firstName = nameInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // create user
            Auth.auth().createUser(withEmail: email, password: password) {(result,err) in
                
                // check for errors
                if err != nil {
                    // there was an error
                    self.showError("Error creating user")
                }
                else{
                    // successful store data
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstName, "uid": result!.user.uid]) {
                        (error) in
                            if error != nil{
                                // display error
                                print(error!.localizedDescription)
                                self.showError("Error saving user data")
                        }
                    }
                    
                    //
                    self.performSegue(withIdentifier: C.SignUpSegue, sender: self)
                    print("successful")
                }
                
            }
        }
    }
    
    
    func showError(_ message:String){
        // change label text and visibility
        errorLabel.isHidden = false
        errorLabel.text = message
        
    }
    
    
    
    
    
    
    
    // changing Input borders & placeholder color
    func editInputs(){
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        for input in Inputs{
            input.layer.cornerRadius = 15
            var statement: String
            switch count{
                case 0: statement = "type your name"
                case 1: statement = "type your email"
                case 2: statement = "type your password"
            default:
                statement = "none"
            }
            
            input.attributedPlaceholder = NSAttributedString(
                string: statement, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBackground, .paragraphStyle: centeredParagraphStyle]
            )
            count+=1
            
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

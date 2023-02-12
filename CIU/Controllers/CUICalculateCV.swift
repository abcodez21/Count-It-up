//
//  CalculateCV.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 1/17/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CUICalculateCV: UIViewController {
    let db = Firestore.firestore()
    
    
    @IBOutlet var calculateView: UIView!
    @IBOutlet var inputs: [UITextField]!
    @IBOutlet var numInputs: [UITextField]!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var descripLabel: UILabel!
    
    
    @IBOutlet var foodNameTextfield: UITextField!
    @IBOutlet var caloriesTextfield: UITextField!
    @IBOutlet var proteinTextfield: UITextField!
    @IBOutlet var carbsTextfield: UITextField!
    @IBOutlet var fatsTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descripLabel.sizeToFit()
        descripLabel.numberOfLines = 0
        calculateView.layer.cornerRadius = 40
        addBtn.layer.cornerRadius = 15
        for input in inputs {
            input.layer.cornerRadius = 15
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addPressed(_ sender: UIButton)  {
        let date = Utilities.editDate(format: "MM dd yyyy", date: datePicker.date)
        
        
        if areFieldsValid(){
            
            let data = ["FoodName": foodNameTextfield.text!,
                        "Calories":Int(caloriesTextfield.text!)!,
                        "Protein":Int(proteinTextfield.text!)!,
                        "Carbs":Int(carbsTextfield.text!)!,
                        "Fats":Int(fatsTextfield.text!)!] as [String : Any]
            if let userAccount = Auth.auth().currentUser?.email{
                var totalFoods: Int = 0
                var totalCalories: Int = 0
                var totalProtien: Int = 0
                var totalCarbs: Int = 0
                var totalFats: Int = 0
                
                // inputing data
                let docRef = db.collection(userAccount).document(date)
                checkDouble(docRef: docRef, userAccount: userAccount, data: data, date: date)
                
                
                // loading data
                db.collection(userAccount).document(date).getDocument { (document, error) in
                    if error == nil {
                        if document != nil && document!.exists{
                            let documentData = document!.data()
//
                            totalFoods = documentData?.count ?? -1
                            for doc in documentData ?? [:]{
                                if let list = documentData![doc.key] as? [String: Any] {
                                    totalCalories += list["Calories"] as! Int
                                    totalProtien += list["Protein"] as! Int
                                    totalCarbs += list["Carbs"] as! Int
                                    totalFats += list["Fats"] as! Int
                                }
                            }
                            self.finalLabelEdit(totalFoods: totalFoods,
                                                totalCalories: totalCalories,
                                                totalCarbs: totalCarbs,
                                                totalProtien: totalProtien,
                                                totalFats: totalFats)
                        }
                        
                        
                    }
                }

                

            }
            
                        
           
            
        }
    }
    
    func areFieldsValid() -> Bool{
        
        // check if inputs are fill if not 
        if Utilities.isInputEmpty(inputs: inputs, textError: "Empty field"){
            return false
        }
    
        if !Utilities.isInt(inputs: numInputs) {
            return false
        }
        
        return true
    }
    
    
    
    
    
    
    func finalLabelEdit(totalFoods: Int, totalCalories: Int, totalCarbs: Int, totalProtien: Int, totalFats: Int){
        self.descripLabel.text = Utilities.editDataLabel(totalFood: totalFoods,
                                                    totalCalories: totalCalories,
                                                    totalProtien: totalProtien,
                                                    totalCarbs: totalCarbs,
                                                    totalFats: totalFats)
        
    }
    func checkDouble(docRef: DocumentReference, userAccount: String, data: [String : Any], date: String){
        
            docRef.getDocument(source: .cache) { (document, error) in
                var double = true
                var foodText = self.foodNameTextfield.text!
                let count = 0
                
                while double {
                    if (document?.get(foodText)) != nil {
                        foodText = foodText+String(count)
                        double = true
                        
                    }else{
                        self.db.collection(userAccount).document(date).setData([foodText: data], merge: true)
                        double = false
                        
                    }
                    
                }
                
            }
        
    }
    
}

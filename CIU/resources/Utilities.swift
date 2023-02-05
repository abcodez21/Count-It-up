//
//  Utilities.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 1/19/23.
//

import Foundation
import UIKit


class Utilities {
    
    static var foodNames: [String] = []
    static  let centeredParagraphStyle = NSMutableParagraphStyle()
   
    static func isPasswordValid (_ password : String) -> Bool{
        let passwordTest = NSPredicate(format:
                                        "SELF MATCHES %@",
                                       "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    static var historyLoadData: Any = ()
    static func editDataLabel(totalFood: Int,
                       totalCalories: Int,
                       totalProtien: Int,
                       totalCarbs: Int,
                       totalFats: Int) -> String {
        return "Total items: \(totalFood ), Calories: \(totalCalories ), Protein: \(totalProtien)g, Carbs: \(totalCarbs)g, Fats: \(totalFats)g"
    }
    
    
    static func editDate(format: String, date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func isInputEmpty(inputs: [UITextField], textError: String = "please fill in field") -> Bool{
        
        Utilities.centeredParagraphStyle.alignment = .center
        for input in inputs{
            if input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                input.attributedPlaceholder = NSAttributedString(
                    string: textError, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed, .paragraphStyle: Utilities.centeredParagraphStyle]
                )
                return true
            }
            
        }
        return false
    }
    
    static func isInt(inputs: [UITextField]) -> Bool{
        
        for input in inputs{
            let text = Int(input.text!) ?? -9999
            if text == -9999{
                input.text = ""
                input.attributedPlaceholder = NSAttributedString(
                string: "enter number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed, .paragraphStyle: Utilities.centeredParagraphStyle])
                return false
            }
        }
        return true
    }
    
    
}

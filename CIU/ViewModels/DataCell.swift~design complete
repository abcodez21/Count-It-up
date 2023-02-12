//
//  DataCell.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 1/28/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DataCell: UITableViewCell {
    let db = Firestore.firestore()
    
    var delegate: InfoHistory?
    
    @IBOutlet var dataBubble: UIView!
    @IBOutlet var DatePicked: UILabel!
    @IBOutlet var FoodNameLabel: UILabel!
    @IBOutlet var DataLabel: UILabel!
    @IBOutlet var removeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataBubble.layer.cornerRadius = dataBubble.frame.size.height / 5
        removeBtn.layer.cornerRadius = removeBtn.frame.size.width / 2
        FoodNameLabel.isHidden = true
        DatePicked.isHidden = true
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func removeButtonPresssed(_ sender: Any) {
        
        if let userAccount = Auth.auth().currentUser?.email{
            db.collection(userAccount).document(DatePicked.text!).updateData([FoodNameLabel.text!:FieldValue.delete()])
            delegate?.loadData()
        }
        
    }
    
}

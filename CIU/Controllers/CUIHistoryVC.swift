//
//  HistoryVC.swift
//  CIU
//
//  Created by Abdallahi Thiaw on 1/27/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol InfoHistory{
    func loadData()
}

class CUIHistoryVC: UIViewController, InfoHistory, UITableViewDelegate {
    let db = Firestore.firestore()

    
    @IBOutlet var Dataview: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var totalEveryThing: UILabel!
    
    
    
    var stats: [info] = []
    var dataTitleNames:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Dataview.delegate = self
        Dataview.dataSource = self
        Dataview.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
       
        loadData()
    }
    
    
    func loadData(){
        stats = []
        dataTitleNames = []
        if let userAccount = Auth.auth().currentUser?.email{
            
            
            var totalCalories: Int = 0
            var totalProtien: Int = 0
            var totalCarbs: Int = 0
            var totalFats: Int = 0
            
            let date = Utilities.editDate(format: "MM dd yyyy", date: datePicker.date)

            db.collection(userAccount).document(date).getDocument { (document, error) in
                if error == nil {
                    if document != nil && document!.exists{
                        let documentData = document!.data()
                        self.dataTitleNames.append(contentsOf: documentData!.keys)
                        for doc in documentData ?? [:]{
                            if let list = documentData![doc.key] as? [String: Any] {
                                self.stats.append(info(data: "Food name: \(list["FoodName"]!), Calories: \(list["Calories"]!), Protein: \(list["Protein"]!)g, Carbs: \(list["Carbs"]!)g, Fats: \(list["Fats"]!)g "))
                                
                                
                                totalCalories += list["Calories"] as! Int
                                totalProtien += list["Protein"] as! Int
                                totalCarbs += list["Carbs"] as! Int
                                totalFats += list["Fats"] as! Int
                                
                                DispatchQueue.main.async {
                                    self.Dataview.reloadData()
                                    
                                }
                            }
                        }
                        self.totalEveryThing.text = Utilities.editDataLabel(totalFood: self.dataTitleNames.count,
                                                                       totalCalories: totalCalories,
                                                                       totalProtien: totalProtien,
                                                                       totalCarbs: totalCarbs,
                                                                       totalFats: totalFats)
                        DispatchQueue.main.async {
                            self.Dataview.reloadData()
                            
                        }
                    }
                }
            }
        }
    }

    
    
}


extension CUIHistoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! DataCell
        cell.DataLabel.sizeToFit()
        cell.DataLabel.numberOfLines = 0
        cell.DataLabel.text = "\(stats[indexPath.row].data)"
        cell.FoodNameLabel.text =  self.dataTitleNames[indexPath.row]
        cell.DatePicked.text = Utilities.editDate(format: "MM dd yyyy", date: datePicker.date)
        cell.delegate = self
        
        return cell
    }
    
    
}





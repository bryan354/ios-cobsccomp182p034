//
//  MainTableViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/1/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

struct cell{
    
    var eventtitle : String
    var description : String
//    var eventimgurl : String
    
}

class TableViewController: UITableViewController {
    
    var cellArr = [cell](){
        
        didSet{
            tableView.reloadData()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cellData()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cells = tableView.dequeueReusableCell(withIdentifier: "Maincell") as! MainTableViewCell

        cells.EventName.text = cellArr[indexPath.row].eventtitle
        cells.DescriptionLable.text = cellArr[indexPath.row].description
        
//        let img = URL(string: cellArr[indexPath.row].eventimgurl)
//        cells.EventImg.kf.setImage(with: img)
        
        
        
        return cells
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 400
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return cellArr.count
    }
    
    func cellData(){
        
        let db = Firestore.firestore()
        db.collection("NewEvents").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let EventTitle = document.data()["Eventname"] as? String
                    let EventDesc = document.data()["description"] as? String
//                    let imgurl =  document.data()["eventimgurl"] as? String
                    let events = cell(eventtitle: EventTitle!, description: EventDesc!)
                    
                    self.cellArr.append(events)
                    self.tableView.reloadData()
                    
                    print(events)
                }
            }
            
            print(self.cellArr)
            
            
        }
        
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let Home = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
//        
//        Home?.Ename = cellArr[indexPath.row].eventtitle
//        Home?.Edescription = cellArr[indexPath.row].eventdes
//        Home?.Eimgurl = cellArr[indexPath.row].eventimgurl
//        
//        self.navigationController?.pushViewController(Home!, animated:true)
//        
//    }
    
    
}



//
//  DetailViewController.swift
//  Nibm-Events
//
//  Created by Bryan Charles on 3/2/20.
//  Copyright © 2020 Bryan Charles. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var Eventname:
    UILabel!
    
    @IBOutlet weak var edesc:
    UILabel!
    var ename = ""
    var desc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        Eventname.text = "\(ename)"
        edesc.text = "\(desc)"

        // Do any additional setup after loading the view.
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

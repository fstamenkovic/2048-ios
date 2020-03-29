//
//  ViewController.swift
//  2048
//
//  Created by Filip Stamenkovic on 3/28/20.
//  Copyright © 2020 Filip Stamenkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label00: UILabel!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label20: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var label22: UILabel!
    
    var fields = [[UILabel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize_game()
        
    }
    
    func initialize_game(){
        populate_fields()
        initialize_fields()
    }
    
    func populate_fields(){
        fields.append([label00, label01, label02])
        fields.append([label10, label11, label12])
        fields.append([label20, label21, label22])
    }
    
    func initialize_fields(){
        
        // set all cells to empty and grey
        for row in fields{
            for cell in row{
                cell.backgroundColor = UIColor.lightGray
                cell.text = ""
            }
        }
        
        // populate a random field with a "2"
        let num1 = Int.random(in: 0 ... 2)
        let num2 = Int.random(in: 0 ... 2)
        
        fields[num1][num2].text = String(2)
        
        var num3 = Int.random(in: 0 ... 2)
        var num4 = Int.random(in: 0 ... 2)
        
        while num1 == num3 && num2 == num4 {
            num3 = Int.random(in: 0 ... 2)
            num4 = Int.random(in: 0 ... 2)
        }
        
        fields[num3][num4].text = String(4)
    }

   
    @IBAction func swipeRight(_ sender: Any) {
        print("swipe right")
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        print("swipeLeft")
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        print("swipeDown")
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        print("swipe Up")
    }
    
    
}


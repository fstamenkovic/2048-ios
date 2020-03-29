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
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label13: UILabel!
    @IBOutlet weak var label20: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var label23: UILabel!
    @IBOutlet weak var label30: UILabel!
    @IBOutlet weak var label31: UILabel!
    @IBOutlet weak var label32: UILabel!
    @IBOutlet weak var label33: UILabel!
    
    var fields = [[UILabel]]()
    var current_values = Array(repeating: [0, 0, 0, 0], count: 4)
    
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
        fields.append([label00, label01, label02, label03])
        fields.append([label10, label11, label12, label13])
        fields.append([label20, label21, label22, label23])
        fields.append([label30, label31, label32, label33])
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
        let num1 = Int.random(in: 0 ... 3)
        let num2 = Int.random(in: 0 ... 3)
        
        fields[num1][num2].text = String(2)
        
        var num3 = Int.random(in: 0 ... 3)
        var num4 = Int.random(in: 0 ... 3)
        
        while num1 == num3 && num2 == num4 {
            num3 = Int.random(in: 0 ... 3)
            num4 = Int.random(in: 0 ... 3)
        }
        
        fields[num3][num4].text = String(4)
    }
    
    func initValues(){
        var i = 0
        var j = 0
        for row in fields{
            for cell in row{
                let val = Int(cell.text ?? "0")
                current_values[i][j] = val ?? 0
                j += 1
            }
            i += 1
            j = 0
        }
        
        //print(current_values)
    }
    
    func addNumber(){
        var num1 = Int.random(in: 0 ... 3)
        var num2 = Int.random(in: 0 ... 3)
        
        while current_values[num1][num2] != 0 {
            num1 = Int.random(in: 0 ... 3)
            num2 = Int.random(in: 0 ... 3)
        }
        
        current_values[num1][num2] = 2
    }
    
    func redrawField(){
        for i in 0 ... 3 {
            for j in 0 ... 3 {
                if current_values[i][j] == 0 {
                    fields[i][j].text = ""
                } else {
                    fields[i][j].text = String(current_values[i][j])
                }
            }
        }
    }

   
    @IBAction func swipeRight(_ sender: Any) {
        print("swipe right")
        initValues()
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        print("swipeLeft")
        initValues()
        //var new_values = Array(repeating: [0, 0, 0, 0], count: 4)
        
        for i in 0...3{
            // first, move all values as left as possible
            var curr_index = 0
            var index_ahead = 0
            while index_ahead < 4 {
                if current_values[i][index_ahead] != 0 {
                    current_values[i][curr_index] = current_values[i][index_ahead]
                    curr_index += 1
                }
                index_ahead += 1
            }
            while curr_index < 4 {
                current_values[i][curr_index] = 0
                curr_index += 1
            }
            
            print("i: \(i)")
            print("moved zeros: \(current_values[i])")
            
            //now, collapse values
            curr_index = 0
            
            while curr_index < 3 {
                if current_values[i][curr_index] == current_values[i][curr_index+1]{
                    current_values[i][curr_index] *= 2
                    current_values[i][curr_index+1] = 0
                    curr_index += 1
                }
                curr_index += 1
            }
            
            print("collapsed: \(current_values[i])")
            
            index_ahead = 0
            curr_index = 0
            
            while index_ahead < 4 {
                if current_values[i][index_ahead] != 0 {
                    current_values[i][curr_index] = current_values[i][index_ahead]
                    curr_index += 1
                }
                index_ahead += 1
            }
            
            while curr_index < 4 {
                current_values[i][curr_index] = 0
                curr_index += 1
            }
            
            print("moved zeros: \(current_values[i])")
        }
        
        addNumber()
        redrawField()
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        print("swipeDown")
        initValues()
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        print("swipe Up")
        initValues()
    }
    
    
}


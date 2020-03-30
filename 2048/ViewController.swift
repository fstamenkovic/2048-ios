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
    let label_colors = [0: UIColor.lightGray,
                        2: UIColor.gray,
                        4: UIColor.darkGray,
                        8: UIColor.green,
                        16: UIColor.blue,
                        32: UIColor.orange,
                        64: UIColor.yellow,
                        128: UIColor.systemPink,
                        256: UIColor.red,
                        512: UIColor.brown,
                        1024: UIColor.green,
                        2048: UIColor.systemPink]
    
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
                fields[i][j].backgroundColor = label_colors[current_values[i][j]]
            }
        }
    }
    
    func moveZeroes(_ arr: [Int]) -> [Int] {
        var new_arr = arr
        var curr_index = 0
        var index_ahead = 0
        while index_ahead < 4 {
            if arr[index_ahead] != 0 {
                new_arr[curr_index] = new_arr[index_ahead]
                curr_index += 1
            }
            index_ahead += 1
        }
        while curr_index < 4 {
            new_arr[curr_index] = 0
            curr_index += 1
        }
        
        return new_arr
    }
    
    func collapseCol(_ arr: [Int]) -> [Int] {
        
        var new_col = arr
        var curr_index = 0
        
        while curr_index < 3 {
            if new_col[curr_index] == new_col[curr_index+1]{
                new_col[curr_index] *= 2
                new_col[curr_index+1] = 0
                curr_index += 1
            }
            curr_index += 1
        }
        
        return new_col
    }
    
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        var new_matrix = Array(repeating: [0, 0, 0, 0], count: 4)
        
        for i in 0...3 {
            for j in 0...3 {
                new_matrix[j][i] = matrix[i][j]
            }
        }
        
        return new_matrix
    }

    @IBAction func swipeRight(_ sender: Any) {
        print("swipe right")
        initValues()
        
        for i in 0...3 {
            var new_col = current_values[i]
            new_col.reverse()
            new_col = moveZeroes(new_col)
                
            print("i: \(i)")
            print("moved zeros: \(current_values[i])")
            
            new_col = collapseCol(new_col)
            
            print("collapsed: \(current_values[i])")
            
            new_col = moveZeroes(new_col)
            
            new_col.reverse()
            current_values[i] = new_col
            
            print("moved zeros: \(current_values[i])")
        }
        
        addNumber()
        redrawField()
        
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        print("swipeLeft")
        initValues()
        //var new_values = Array(repeating: [0, 0, 0, 0], count: 4)
        
        for i in 0...3 {
            // first, move all values as left as possible
            var new_col = moveZeroes(current_values[i])
            
            print("i: \(i)")
            print("moved zeros: \(current_values[i])")
            
            new_col = collapseCol(new_col)
            
            print("collapsed: \(current_values[i])")
            
            new_col = moveZeroes(new_col)
            
            current_values[i] = new_col
            
            print("moved zeros: \(current_values[i])")
        }
        
        addNumber()
        redrawField()
    }
    
    @IBAction func swipeDown(_ sender: Any) {
        print("swipeDown")
        initValues()
        
        var transposed_values = transpose(current_values)
        
        for i in 0...3 {
            // first, move all values as left as possible
            var new_col = transposed_values[i]
            new_col.reverse()
            new_col = moveZeroes(new_col)
                
            print("i: \(i)")
            print("moved zeros: \(transposed_values[i])")
            
            new_col = collapseCol(new_col)
            
            print("collapsed: \(transposed_values[i])")
            
            new_col = moveZeroes(new_col)
            
            new_col.reverse()
            transposed_values[i] = new_col
            
            print("moved zeros: \(transposed_values[i])")
        }
        
        current_values = transpose(transposed_values)
        addNumber()
        redrawField()
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        print("swipe Up")
        initValues()
        
        var transposed_values = transpose(current_values)
        
        for i in 0...3 {
            // first, move all values as left as possible
            var new_col = moveZeroes(transposed_values[i])
            
            print("i: \(i)")
            print("moved zeros: \(transposed_values[i])")
            
            new_col = collapseCol(new_col)
            
            print("collapsed: \(transposed_values[i])")
            
            new_col = moveZeroes(new_col)
            
            transposed_values[i] = new_col
            
            print("moved zeros: \(transposed_values[i])")
        }
        
        current_values = transpose(transposed_values)
        addNumber()
        redrawField()
    }
    
    
}


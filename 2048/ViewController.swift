//
//  ViewController.swift
//  2048
//
//  Created by Filip Stamenkovic on 3/28/20.
//  Copyright © 2020 Filip Stamenkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


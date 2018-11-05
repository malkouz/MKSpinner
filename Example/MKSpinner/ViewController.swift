//
//  ViewController.swift
//  MKSpinner
//
//  Created by Moayad Al kouz on 06/27/2016.
//  Copyright (c) 2016 Moayad Al kouz. All rights reserved.
//

import UIKit
import MKSpinner
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFullSpinner(_ sender: UIButton){
        _ = MKFullSpinner.show("Full Spinner", animated: true, duration: 3.0)
        self.perform(#selector(ViewController.hideFullSpinner), with: nil, afterDelay: 10)
    }
    
    @IBAction func ShowASpinner(_ sender: UIButton){
        _ = MKNSpinner.show("N Spinner")
        self.perform(#selector(ViewController.hideNSpinner), with: nil, afterDelay: 10)
    }
    
    @objc func hideFullSpinner(){
        MKFullSpinner.hide()
    }
    
    @objc func hideNSpinner(){
        MKNSpinner.hide()
    }

}


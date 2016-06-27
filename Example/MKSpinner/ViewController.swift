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
    
    @IBAction func showFullSpinner(sender: UIButton){
        MKFullSpinner.show("Full Spinner")
        self.performSelector(#selector(ViewController.hideFullSpinner), withObject: nil, afterDelay: 10)
    }
    
    @IBAction func ShowASpinner(sender: UIButton){
        MKNSpinner.show("N Spinner")
    self.performSelector(#selector(ViewController.hideNSpinner), withObject: nil, afterDelay: 10)
//        MKFullSpinner.showWithDelay(10, title: "Full Spinner", animated: true);
    }
    
    func hideFullSpinner(){
        MKFullSpinner.hide()
    }
    
    func hideNSpinner(){
        MKNSpinner.hide()
    }

}


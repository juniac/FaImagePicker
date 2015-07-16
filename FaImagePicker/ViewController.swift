//
//  ViewController.swift
//  FaImagePicker
//
//  Created by juniac on 07/16/2015.
//  Copyright (c) 2015 maneuling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func imagePickerButtonAction(sender: UIButton) {
        let storyboard = UIStoryboard(name: "FaImagePicker", bundle: nil)
        let faImagePicker = storyboard.instantiateViewControllerWithIdentifier("FaImagePicker") as! UINavigationController!
        self.presentViewController(faImagePicker, animated: true, completion: {})
        
    }
}


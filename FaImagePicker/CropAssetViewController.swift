//
//  CropAssetViewController.swift
//  FaImagePicker
//
//  Created by juniac on 07/16/2015.
//  Copyright (c) 2015 maneuling. All rights reserved.
//

import UIKit

class CropAssetViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var ratio1x1Button: UIButton!
    @IBOutlet weak var ratio4x3Button: UIButton!
    @IBOutlet weak var ratio3x4Button: UIButton!
    @IBOutlet weak var ratioOriginalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        let faImagePickerController:FaImagePickerController = self.navigationController as! FaImagePickerController
        faImagePickerController.shouldBeDone()
        
    }

}

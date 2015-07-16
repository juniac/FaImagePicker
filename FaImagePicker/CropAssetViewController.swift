//
//  CropAssetViewController.swift
//  FaImagePicker
//
//  Created by juniac on 07/16/2015.
//  Copyright (c) 2015 maneuling. All rights reserved.
//

import UIKit

struct ASSET_ASPECT {
    static let RATIO_ORIGINAL = 0
    static let RATIO_1x1 = 1
    static let RATIO_4x3 = 2
    static let RATIO_3x4 = 3
    
}
class CropAssetViewController: UIViewController {

    var image:UIImage!
//    var panGesture:UIPanGestureRecognizer!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var ratio1x1Button: UIButton!
    @IBOutlet weak var ratio4x3Button: UIButton!
    @IBOutlet weak var ratio3x4Button: UIButton!
    @IBOutlet weak var ratioOriginalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: "panAction:")
        self.imageView.addGestureRecognizer(panGesture)
        if image != nil {
            self.imageView.image = image
            let frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_ORIGINAL)
            let imageFrameSize = self.imageViewSizeWithFrame(frameSize)
            self.changeCroppingAreaWithAnimation(true, frame: frameSize, imageFrameSize: imageFrameSize)
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panAction(recognizer:UIPanGestureRecognizer) {
        println(1)
    }
    
    func frameSizeWithAspectRatio(ratio:Int) -> CGSize {
        let availableSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height - self.menuView.bounds.height)
        var frameSize:CGSize = availableSize
        println(availableSize)
        let frameRatio = availableSize.width / availableSize.height
    
        switch ratio {
        case ASSET_ASPECT.RATIO_1x1:
            if frameRatio > 1 {
                frameSize = CGSizeMake(availableSize.height, availableSize.height)
            } else {
                frameSize = CGSizeMake(availableSize.width, availableSize.width)
            }
            break;
        case ASSET_ASPECT.RATIO_4x3:
            if frameRatio > 4 / 3 {
                
                frameSize = CGSizeMake(availableSize.height * (4 / 3), availableSize.height)
            } else {
                frameSize = CGSizeMake(availableSize.width, availableSize.width / (4 / 3))
                
            }
            break;
        case ASSET_ASPECT.RATIO_3x4:
            if frameRatio > 3 / 4 {
                frameSize = CGSizeMake(availableSize.height * (3 / 4), availableSize.height)
            } else {
                frameSize = CGSizeMake(availableSize.width, availableSize.width / (3 / 4))
                
            }
            break;
            
        case ASSET_ASPECT.RATIO_ORIGINAL:
            let imageRatio = self.image.size.width / self.image.size.height
            if frameRatio > imageRatio {
                frameSize = CGSizeMake(availableSize.height * imageRatio, availableSize.height)
            } else {
                frameSize = CGSizeMake(availableSize.width, availableSize.width / imageRatio)
            }
            break
        default:
            break
            
        }
        return frameSize
    }
    
    func imageViewSizeWithFrame(size:CGSize) -> CGSize {
        let imageRatio = self.image.size.width / self.image.size.height

        let frameRatio = size.width / size.height
        var imageFrameSize:CGSize = CGSizeZero
        
        if imageRatio > 1 {
            print(size)
            imageFrameSize = CGSizeMake(size.height * imageRatio, size.height)
        } else {
            print(size)
            imageFrameSize = CGSizeMake(size.width, size.width / imageRatio)
        }
        return imageFrameSize
    }

    func changeCroppingAreaWithAnimation(animation:Bool, frame:CGSize, imageFrameSize:CGSize) {
        let availableSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height - self.menuView.bounds.height)
        let imageViewFrame = CGRectMake((availableSize.width - imageFrameSize.width) / 2, (availableSize.height - imageFrameSize.height) / 2, imageFrameSize.width, imageFrameSize.height)
        
        if animation == true {
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.8, options: .CurveLinear, animations: {
                self.imageView.frame = imageViewFrame
                }, completion: { finished in })
        } else {
                self.imageView.frame = imageViewFrame
        }


    }
    
    @IBAction func ratioButtonAction(sender: UIButton) {
        var frameSize:CGSize = CGSizeZero
        var imageFrameSize:CGSize
        if sender == ratio1x1Button {
            frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_1x1)
        } else if sender == ratio3x4Button {
            frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_3x4)
        } else if sender == ratio4x3Button {
            frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_4x3)
        } else if sender == ratioOriginalButton {
            frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_ORIGINAL)
        }
        imageFrameSize = self.imageViewSizeWithFrame(frameSize)
        self.changeCroppingAreaWithAnimation(true, frame: frameSize, imageFrameSize: imageFrameSize)
//        println("frameSize:\(frameSize)")
//        println("imageFrameSize:\(imageFrameSize)")
    }
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        let faImagePickerController:FaImagePickerController = self.navigationController as! FaImagePickerController
        faImagePickerController.image = self.image
        faImagePickerController.shouldBeDone()
        
    }

}

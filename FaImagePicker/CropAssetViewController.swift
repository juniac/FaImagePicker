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
class CropAssetViewController: UIViewController, UIScrollViewDelegate {

    var image:UIImage!
    var imageView = UIImageView()
    
    var scrollView: UIScrollView! = UIScrollView()

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var ratio1x1Button: UIButton!
    @IBOutlet weak var ratio4x3Button: UIButton!
    @IBOutlet weak var ratio3x4Button: UIButton!
    @IBOutlet weak var ratioOriginalButton: UIButton!
    
    var topDimmedView: UIView = UIView()
    var bottomDimmedView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.addSubview(topDimmedView)
        self.view.addSubview(bottomDimmedView)
        topDimmedView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 1)
        bottomDimmedView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 1)
        topDimmedView.alpha = 0.7
        bottomDimmedView.alpha = 0.7
        scrollView.scrollEnabled = true
        scrollView.bounces = true
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        self.scrollView.addSubview(imageView)
        self.scrollView.delegate = self
        
        self.view.bringSubviewToFront(menuView)
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidLayoutSubviews() {
        if image != nil {
            self.imageView.image = image
            let frameSize = self.frameSizeWithAspectRatio(ASSET_ASPECT.RATIO_ORIGINAL)
            let imageFrameSize = self.imageViewSizeWithFrame(frameSize)
            self.changeCroppingAreaWithAnimation(false, frame: frameSize, imageFrameSize: imageFrameSize)
        }
    }
    override func viewDidAppear(animated: Bool) {

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func frameSizeWithAspectRatio(ratio:Int) -> CGSize {
        let availableSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height - self.menuView.bounds.height - self.topLayoutGuide.length)
        var frameSize:CGSize = availableSize
//        println(availableSize)
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
            imageFrameSize = CGSizeMake(size.height * imageRatio, size.height)
        } else {
            imageFrameSize = CGSizeMake(size.width, size.width / imageRatio)
        }
        return imageFrameSize
    }

    func changeCroppingAreaWithAnimation(animation:Bool, frame:CGSize, imageFrameSize:CGSize) {
        
        
        println("changeCroppingArea")
        let availableSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height - self.menuView.bounds.height - self.topLayoutGuide.length)
        let scrollViewFrame = CGRectMake((availableSize.width - frame.width) / 2, (availableSize.height - frame.height) / 2 + self.topLayoutGuide.length, frame.width, frame.height)
        
        let topDimmedViewFrame = CGRectMake(0, self.topLayoutGuide.length, self.view.bounds.width, scrollViewFrame.origin.y - self.topLayoutGuide.length)
        let bottomDimmedViewFrame = CGRectMake(0, CGRectGetMaxY(scrollViewFrame), self.view.bounds.width, self.view.bounds.height - CGRectGetMaxY(scrollViewFrame) - menuView.bounds.height)
        scrollView.contentSize = imageFrameSize
        scrollView.contentInset = UIEdgeInsetsZero
        let imageViewFrame = CGRectMake(0, 0, imageFrameSize.width, imageFrameSize.height)
        let offset = CGPointMake((imageFrameSize.width - scrollViewFrame.width) / 2, (imageFrameSize.height - scrollViewFrame.height) / 2)
        self.scrollView.setContentOffset(offset, animated: false)
        if animation == true {
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.8, options: .CurveLinear, animations: {
                self.imageView.frame = imageViewFrame
                self.scrollView.frame = scrollViewFrame
                self.topDimmedView.frame = topDimmedViewFrame
                self.bottomDimmedView.frame = bottomDimmedViewFrame
                }, completion: { finished in

            })
        } else {

                self.scrollView.frame = scrollViewFrame
                self.imageView.frame = imageViewFrame
                self.topDimmedView.frame = topDimmedViewFrame
                self.bottomDimmedView.frame = bottomDimmedViewFrame
        }

    }
    
    func cropImage() -> UIImage {
        var scale:CGFloat
        if imageView.frame.width == scrollView.frame.width {
            scale = self.image.size.width / imageView.frame.width
        } else {
            scale = self.image.size.height / imageView.frame.height
        }
        let resultImageSize = CGSizeMake(self.scrollView.frame.size.width * scale, self.scrollView.frame.size.height * scale)
        println(image.size)
        println(resultImageSize)
        

        println(self.image.scale)
        
        let resultImageOrigin = CGPointMake(self.scrollView.contentOffset.x * scale, self.scrollView.contentOffset.y * scale)
        let rect = CGRect(origin: resultImageOrigin, size: resultImageSize)

        
        let imageRef = CGImageCreateWithImageInRect(self.image.CGImage, rect)
        let cropImage = UIImage(CGImage: imageRef, scale: self.image.scale, orientation: self.image.imageOrientation)!
        return cropImage
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
        
        let cropImage = self.cropImage()
        let faImagePickerController:FaImagePickerController = self.navigationController as! FaImagePickerController
        faImagePickerController.image = cropImage
        faImagePickerController.shouldBeDone()
        
    }

}

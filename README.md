# FaImagePicker

FaImagePicker is a Image Picker for iOS written in Swift 1.2

https://youtu.be/z2Jeo21YgVk

[![Screencast](http://img.youtube.com/vi/z2Jeo21YgVk/0.jpg)](https://youtu.be/z2Jeo21YgVk)



## Usage 

To run the example project, clone repositaty.

###### Swift
```swift
    @IBAction func imagePickerButtonAction(sender: UIButton) {
        let storyboard = UIStoryboard(name: "FaImagePicker", bundle: nil)
        let faImagePicker = storyboard.instantiateViewControllerWithIdentifier("FaImagePicker") as! FaImagePickerController!
        faImagePicker.imagePickerDelegate = self
        self.presentViewController(faImagePicker, animated: true, completion: {})
        
    }
    
    func faImagePickerControllerDidCancel(picker: FaImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: {
        
        })
    }
    
    func faImagePickerController(picker: FaImagePickerController, didFinishPickingImage image:UIImage?) {

        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: {
            
        })

    }

```

## Requirement
iOS 8, Swift 1.2






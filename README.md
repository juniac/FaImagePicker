# FaImagePicker

FaImagePicker is a Image Picker for iOS written in Swift 2.0

https://youtu.be/z2Jeo21YgVk

[![Screencast](http://img.youtube.com/vi/z2Jeo21YgVk/0.jpg)](https://youtu.be/z2Jeo21YgVk)



## Usage

To run the example project, clone repositaty.

###### Swift
```swift
    //Open Image Picker ViewController
    @IBAction func imagePickerButtonAction(sender: UIButton) {
        let storyboard = UIStoryboard(name: "FaImagePicker", bundle: nil)
        let faImagePicker = storyboard.instantiateViewControllerWithIdentifier("FaImagePicker") as! FaImagePickerController!
        faImagePicker.imagePickerDelegate = self
        self.presentViewController(faImagePicker, animated: true, completion: {})

    }

    //ImagePicker Cancel Delegate
    func faImagePickerControllerDidCancel(picker: FaImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: {

        })
    }

    //ImagePicker finished Crop/Select Delegate
    func faImagePickerController(picker: FaImagePickerController, didFinishPickingImage image:UIImage?) {

        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: {

        })

    }

```

## Requirement
iOS 8, Swift 2.0

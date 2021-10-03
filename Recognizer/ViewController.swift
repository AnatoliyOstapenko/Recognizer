//
//  ViewController.swift
//  Recognizer
//
//  Created by MacBook on 29.09.2021.
//

import UIKit

// Don't forget in plist add Privacy - Camera Usage Description and Photo Library Usage
// 1 add CoreML and Vision
import CoreML
import Vision


// 2 add UIImagePickerControllerDelegate and UINavigationControllerDelegate
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 3 initialize manager the system interfaces
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4 activate delegate of UIImagePickerControllerDelegate
        imagePicker.delegate = self
        // 5 to pick a source we want to get access (camera or photo library)
        imagePicker.sourceType = .photoLibrary
        // 6 restrict allow to edit pic
        imagePicker.allowsEditing = false
    }
    
    // 8 default UIImagePickerControllerDelegate func when user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 9 choose image
        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        // 10 to show choosen image on the screen
        cameraImageView.image = userPickedImage
        
        // convert image to CIImage
        guard let ciImage = CIImage(image: userPickedImage) else { fatalError("Converting UIImage to CIIMage failed")}
        
        //dispatch converted image
        detect(image: ciImage)
        
        
        // dismiss the view controller, mandatory
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    // identifier method
    func detect(image: CIImage) {
        
        // load Core ML model used with Vision framework requests
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model) else { fatalError("Loading CoreML model failed") }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            // get results
            guard let results = request.results as? [VNClassificationObservation] else { fatalError("Process model image failed") }
            // unwrap first most relevant result
            guard let first = results.first?.identifier, let confidence = results.first?.confidence else { return }
            
            let persentage = Double(confidence) * 100
            
            self.navigationItem.title = first
            
            self.topLabel.text = "\(first), confidence is \(String(format: "%.0f", persentage))%"
        }
        
        //create handler to specify image
        let handler = VNImageRequestHandler(ciImage: image)
        // Vision requests to be performed
        do {
            try handler.perform([request])
        } catch { print(error)}
        
        
        
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        // 7 camera is activated when button pressed
        
        present(imagePicker, animated: true, completion: nil)
        
    }
        
    
}


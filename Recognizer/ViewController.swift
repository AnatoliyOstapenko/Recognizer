//
//  ViewController.swift
//  Recognizer
//
//  Created by MacBook on 29.09.2021.
//

import UIKit

// 1 add CoreML and Vision
import CoreML
import Vision


// 2 add UIImagePickerControllerDelegate and UINavigationControllerDelegate
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 3 initialize manager the system interfaces
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4 activate delegate of UIImagePickerControllerDelegate
        imagePicker.delegate = self
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
    
}


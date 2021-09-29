//
//  ViewController.swift
//  Recognizer
//
//  Created by MacBook on 29.09.2021.
//

import UIKit

// add CoreML and Vision
import CoreML
import Vision


// add UIImagePickerControllerDelegate and UINavigationControllerDelegate
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
    
}


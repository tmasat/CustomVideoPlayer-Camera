//
//  CapturedImageViewController.swift
//  customCamera
//
//  Created by Çağrı Tuğberk Masat on 12.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import UIKit
import AVFoundation

class CapturedImageViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var capturedPhotoImageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveToGalleryButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    
    //MARK:- Properties
    var takenPhoto: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capturedPhotoImageView.image = takenPhoto
    }
    
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender == backButton {
            navigationController?.popViewController(animated: true)
        } else if sender == saveToGalleryButton {
            //TODO: Do save action
            
        } else if sender == shareButton {
            //TODO: Do share action
            
        }
    }
    
}

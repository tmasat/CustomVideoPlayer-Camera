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
    var takenPhoto: UIImage?
    
    @IBOutlet weak var capturedPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedPhoto.image = takenPhoto
    }
}

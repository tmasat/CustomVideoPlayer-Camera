//
//  ViewController.swift
//  customCamera
//
//  Created by Çağrı Tuğberk Masat on 11.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageCaptureButton: UIButton!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard #available(iOS 10.2, *) else {exit(0)}
        prepareInputSession()
    }
    override func viewDidAppear(_ animated: Bool) {
        imageCaptureButton.isHidden = false
        prepareInputSession()
    }
    
    @IBAction func imageCaptureButtonPressed(_ sender: Any) {
        imageCaptureButton.isHidden = true
        captureSession?.stopRunning()
        let vc = storyboard?.instantiateViewController(withIdentifier: "CapturedImageViewController") as! CapturedImageViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func prepareInputSession() {
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.frame = view.layer.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
        } catch {
            print("Version Error")
        }
    }
}

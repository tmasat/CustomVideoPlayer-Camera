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
    
    //MARK:- Outlets
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var floatView: CaptureFloatView!
    
    //MARK:- Properties
    let captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    var takePhoto = false
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        prepareCamera()
        
        beginSession()
        
        floatView.delegate = self
    }
    
    /// Camera output frame, layer etc. association
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        captureDevice = availableDevices.first
        
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        captureSession.startRunning()
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String):NSNumber(value: kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "com.customCamera.captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    
    // MARK: - Helpers
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }
    
}


//MARK:- Float View
extension ViewController: CaptureFloatViewDelegate {
    
    func captureButtonTapped() {
        takePhoto = true
    }
    
}


//MARK:- AV Buffer
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto {
            takePhoto = false
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CapturedImageViewController") as! CapturedImageViewController
                    vc.takenPhoto = image
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

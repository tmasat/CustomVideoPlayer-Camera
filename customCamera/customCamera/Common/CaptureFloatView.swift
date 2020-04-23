//
//  CaptureFloatView.swift
//  customCamera
//
//  Created by Berkay Vurkan on 22.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import UIKit

protocol CaptureFloatViewDelegate {
    
    func captureButtonTapped()
}

class CaptureFloatView: UIView {
    
    //MARK:- Outlets
    @IBOutlet var view: UIView!
    @IBOutlet weak var floatView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var captureButton: UIButton!
    
    
    //MARK:- Properties
    var delegate: CaptureFloatViewDelegate?
    

    //MARK:- Parameters
    var cameraSize = CGSize(width: 24, height: 24)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        let nib = UINib(nibName: "CaptureFloatView", bundle: .main)
        view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(view)
        
        setParameters()
        adjustConstraints()
        adjustUI()
    }
    
    
    // MARK: - Helpers
    
    func setParameters() {
        cameraSize.width = 32
        cameraSize.height = 32
    }
    
    func adjustConstraints() {
        guard view != nil else { return }
        
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: ["view": view!])
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: ["view": view!])
        addConstraints(vertical + horizontal)
        
        guard captureImageView != nil else { return }
        
        NSLayoutConstraint(item: captureImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cameraSize.height).isActive = true
        NSLayoutConstraint(item: captureImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cameraSize.width).isActive = true
        NSLayoutConstraint(item: captureImageView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: captureImageView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        guard floatView != nil else { return }
        
        NSLayoutConstraint(item: floatView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: floatView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: floatView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: floatView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: cameraSize.height / 2).isActive = true
        
        guard captureButton != nil else { return }
        
        NSLayoutConstraint(item: captureButton!, attribute: .top, relatedBy: .equal, toItem: captureImageView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: captureButton!, attribute: .leading, relatedBy: .equal, toItem: captureImageView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: captureButton!, attribute: .bottom, relatedBy: .equal, toItem: captureImageView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: captureButton!, attribute: .trailing, relatedBy: .equal, toItem: captureImageView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    func adjustUI() {
        floatView.backgroundColor = .lightBackground
        floatView.clipsToBounds = true
        floatView.layer.cornerRadius = 16.0
        
        captureImageView.contentMode = .scaleAspectFit
        captureImageView.clipsToBounds = true
        captureImageView.layer.cornerRadius = cameraSize.height / 2
        captureImageView.image = .cameraIcon
        captureImageView.backgroundColor = .white
        captureImageView.layer.borderColor = UIColor.darkGray.cgColor
        captureImageView.layer.borderWidth = 1
    }
    
    
    // MARK: - Actions
    
    @IBAction func captureButtonTapped(_ sender: UIButton) {
        self.delegate?.captureButtonTapped()
    }

}

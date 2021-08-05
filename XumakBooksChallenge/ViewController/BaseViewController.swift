//
//  BaseViewController.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import UIKit
import Lottie

class BaseViewController: UIViewController{
    
    // MARK: - UI Properties
    
    private var progressView: UIView?
    private var progressAnimation: LOTAnimationView?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTraslucentNavigationBar()
    }
    
    func setupTraslucentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Progress View Controller
    func showProgressView() {
        if let _: UIView = progressView, let _: LOTAnimationView = progressAnimation {
            removeProgressView()
        }
        
        progressView = UIView(frame: .zero)
        progressView!.backgroundColor = UIColor.white
        progressView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressView!)
            
        NSLayoutConstraint.activate([
            progressView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            progressView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            progressView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            progressView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
            
        progressAnimation = LOTAnimationView( name: "orangeLottie.json" )
        progressAnimation!.loopAnimation = true
        progressAnimation!.play()
            
        progressAnimation!.translatesAutoresizingMaskIntoConstraints = false
        progressView!.addSubview(progressAnimation!)
            
        NSLayoutConstraint.activate([
            progressAnimation!.centerXAnchor.constraint(equalTo: progressView!.centerXAnchor),
            progressAnimation!.centerYAnchor.constraint(equalTo: progressView!.centerYAnchor)
        ])
    }
    
    func removeProgressView() {
        if let _: LOTAnimationView = progressAnimation {
            progressAnimation!.stop()
            progressAnimation!.removeFromSuperview()
            progressAnimation = nil
        }
            
        if let _: UIView = progressView {
            progressView!.removeFromSuperview()
            progressView = nil
        }
    }
}

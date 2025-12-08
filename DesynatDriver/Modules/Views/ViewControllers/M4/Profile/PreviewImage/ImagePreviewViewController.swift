//
//  ImagePreviewViewController.swift
//  DesynatDriver
//
//  Created by fluper on 08/12/25.
//


import UIKit
import SDWebImage

class ImagePreviewViewController: UIViewController, UIScrollViewDelegate {
    
    var imageUrlString: String?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 5.0
        sv.backgroundColor = .black
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
        // Load image from URL
        if let urlString = imageUrlString, let url = URL(string: urlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        
        // Tap to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPreview))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissPreview() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

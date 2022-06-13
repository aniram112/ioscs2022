//
//  BigPictureViewController.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 23.05.2022.
//

import UIKit
final class BigPictureViewController: UIViewController, UIScrollViewDelegate{
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        closeCircle.image = UIImage(systemName: "xmark.circle.fill")
        closeCircle.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        closeCircle.addGestureRecognizer(tap)
        
        var image = UIImage(named: "bigpicture")!
        image = image.aspectFittedToHeight(view.frame.height)
        scrollView.set(image: image)
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @objc func close(_ sender: UITapGestureRecognizer? = nil) {
        appLogger.logger.log(level: .info, message: "closed bigpic")
        //self.dismiss(animated: true, completion: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        //navigationController?.pushViewController(bp, animated: true)
        navigationController?.popViewController(animated: false)
    }
    
    private func setupUI() {
        
        view.addSubview(scrollView)
        view.addSubview(closeCircle)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        closeCircle.translatesAutoresizingMaskIntoConstraints = false
        closeCircle.tintColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: 63),
            closeCircle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            closeCircle.heightAnchor.constraint(equalToConstant: 48),
            closeCircle.widthAnchor.constraint(equalToConstant: 48)
            
            
        ])
        
    }
    
    private lazy var scrollView: ImageScrollView = {
        let scrollview = ImageScrollView.init(frame: view.bounds)
        return scrollview
    }()
    
    private lazy var closeCircle: UIImageView = {
        let ret = UIImageView()
        ret.layer.masksToBounds = true
        return ret
    }()
    
    
}
extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage
    {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }

}


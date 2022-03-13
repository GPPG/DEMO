//
//  ViewController.swift
//  SwiftDemo
//
//  Created by 郭鹏 on 2022/2/4.
//  Copyright © 2022 郭鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var dic = ["1" : "a"]
        
        let dic1 = ["1" : [1,2.3,4]]
        let hhh = dic1["1"]?[2]
        
        
        
        print(dic)
        
        let sss = "123"
                
    }
    
    typealias Filter = (CIImage) -> CIImage
    
    
    
    func blur(radius: Double) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
            ]
            guard let filter = CIFilter(name: "CIGaussianBlur",
                                        parameters: parameters)
                else { fatalError() }
            guard let outputImage = filter.outputImage
                else { fatalError() }
            return outputImage
        }
    }
    
    
    
}


//
//  UIColor+Extension.swift
//  SMPageView
//
//  Created by SMART on 2017/9/6.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

extension UIColor {
    
    //根据颜色值生成颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //根据十六进制字符串生成颜色
    class func hexColor(hex:String) -> UIColor?{
        
        var hex = hex.lowercased()
        
        if hex.contains("0x")||hex.contains("##") {
            hex = (hex as NSString).substring(from: 2)
        }
        
        if hex.contains("#") {
            hex = (hex as NSString).substring(from: 1)
        }
        
        if hex.characters.count < 6 {
            fatalError("Error: Hex Color String format Error!")
        }
        
        let red = (hex as NSString).substring(with: NSRange(location: 0, length: 2))
        let green = (hex as NSString).substring(with: NSRange(location: 2, length: 2))
        let blue = (hex as NSString).substring(with: NSRange(location: 4, length: 2))
        
        var r:Int32 = 0
        Scanner(string: red).scanInt32(&r)
        
        var g:Int32 = 0
        Scanner(string: green).scanInt32(&g)
        
        var b:Int32 = 0
        Scanner(string: blue).scanInt32(&b)
        
        return UIColor.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    //随机色
    class func randomColor () -> UIColor{
        
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        
        return UIColor(r: red, g: green, b: blue)
    }
    
    //根据颜色返回rgb值
    func getRGBValueOfColor() -> (r:Int, g:Int, b:Int) {

        guard let components = self.cgColor.components  else {
            fatalError("Error: not a rgb color!")
        }
        if components.count < 3 {
            fatalError("Error: not a rgb color!")
        }
        
        let red   = Int(components[0]*255)
        let green = Int(components[1]*255)
        let blue  = Int(components[2]*255)
        
        return (r:red,g:green,b:blue)
    }
    
    
}

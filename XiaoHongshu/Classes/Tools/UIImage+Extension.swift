//
//  GenerCircleImage.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/20.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    //加载图片
    //开启位图上下文
    //设置圆形剪切路径：[1]添加路径 [2]添加路径剪切
    //绘制图片
    //从当前位图上下文获取图片
    //关闭位图上下文
    //PNG转换NSData
    //写入路径
    
    
    func makeCircleImage() -> UIImage? {//_ image:UIImage
        
        // 如果需要做裁剪,必须先设置裁剪区域
        
        // 1.开启位图上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        
        // 2.设置圆形裁剪区域
        // 2.1 先描述圆形路径
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        // 2.2 把圆形路径设置为裁剪区域
        path.addClip()
        
        // 3.绘制图像
        self.draw(at: CGPoint.zero)
        
        // 4.把上下文中内容生成一张图片
        let  curImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5.结束上下文
        UIGraphicsEndImageContext();
        
        return curImage ?? nil
        
    }
    
    
    //加载图片
    //开启位图上下文
    //设置圆形剪切路径：[1]添加路径 [2]添加路径剪切
    //绘制图片
    //从当前位图上下文获取图片
    //关闭位图上下文
    //PNG转换NSData
    //写入路径
    
    
    static func createCircleImage(name:String) -> UIImage? {
        
        // 如果需要做裁剪,必须先设置裁剪区域
        // 加载图片
        if  let image = UIImage(named:name) {
            
            // 1.开启位图上下文
            UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
            
            // 2.设置圆形裁剪区域
            // 2.1 先描述圆形路径
            let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            // 2.2 把圆形路径设置为裁剪区域
            path.addClip()
            
            // 3.绘制图像
            image.draw(at: CGPoint.zero)
            
            // 4.把上下文中内容生成一张图片
            let  curImage = UIGraphicsGetImageFromCurrentImageContext()
            
            // 5.结束上下文
            UIGraphicsEndImageContext();
            
            return curImage
        }
        
        return nil
    }
    
    
    
    //    带圆环剪切效果
    //    [1]加载图片
    //    [2]开启位图上下文
    //    [3]添加大圆(外围)路径：路径填充及渲染
    //    [4]添加内部显示路径
    //    [5]添加路径剪切
    //    [6]绘图
    //    [7]从当前位图上下文获取图片
    //    [8]关闭位图上下文
    //    [9]图片格式转换(NSData)
    //    [10]写入路径
    
    static func createCircleImage(color:UIColor, border:CGFloat, name:String) -> UIImage?{
        
        // 加载图片
        if  let image = UIImage(named:name) {
            // 裁剪带圆环的图片
            let borderWH = border;
            
            let bigContextRect = CGRect(x: 0, y: 0, width: image.size.width + 2 * borderWH, height: image.size.height + 2 * borderWH)
            
            // 1.开启位图上下文
            UIGraphicsBeginImageContextWithOptions(bigContextRect.size, false, 0);
            
            // 2.画大圆
            let bigCirclePath = UIBezierPath.init(ovalIn: bigContextRect)
            
            // 设置大圆颜色
            color.set()
            
            bigCirclePath.fill()
            
            // 3.设置裁剪区域
            // 3.1 先描述裁剪区域
            let clipPath = UIBezierPath.init(ovalIn: CGRect(x: borderWH, y: borderWH, width: image.size.width, height: image.size.height))
            clipPath.addClip()
            
            // 4.绘制图片
            image.draw(at: CGPoint(x: borderWH, y: borderWH))
            
            // 5.从上下文内容中生成一张图片
            let curImage = UIGraphicsGetImageFromCurrentImageContext()
            
            // 6.结束上下文
            UIGraphicsEndImageContext();
            
            return curImage;
        }
        
        return nil
        
    }
    
}

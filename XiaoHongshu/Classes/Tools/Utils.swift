//
//  UILabel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/23.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
//import YYText
import TTTAttributedLabel

class Utils {
    
        static func textH(text:String,font:UIFont, width:CGFloat,numberOfLine:UInt = 0) -> CGFloat {
    
            let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font])
    
            let maxSize = CGSize(width: width, height:CGFloat(MAXFLOAT))
            let textH = TTTAttributedLabel.sizeThatFitsAttributedString(attributedText, withConstraints: maxSize, limitedToNumberOfLines: numberOfLine).height
    
            return textH
    
        }
    
//    static func textH(text:String,font:UIFont, width:CGFloat,numberOfLine: UInt = 0)->CGFloat{
//
//        let label = YYLabel()
//
//        label.preferredMaxLayoutWidth = width
//        let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font])
//        label.attributedText = attributedText
//
//        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
//        let layout = YYTextLayout(containerSize: maxSize, text: attributedText)
//
//        label.textLayout = layout
//        label.numberOfLines = numberOfLine
//
//        if let textH = layout?.textBoundingSize.height {
//            return textH
//        }else{
//            return 0
//        }
//
//    }
    
}
extension TTTAttributedLabel{
    func textH(text:String,font:UIFont, width:CGFloat,numberOfLine:UInt = 0,textColor:UIColor = UIColor.darkGray) -> CGFloat {

        let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font])
        self.attributedText = attributedText
        
        let maxSize = CGSize(width: width, height:CGFloat(MAXFLOAT))
        let textSize = TTTAttributedLabel.sizeThatFitsAttributedString(attributedText, withConstraints: maxSize, limitedToNumberOfLines: numberOfLine)
        
        self.numberOfLines = Int(numberOfLine)

        return textSize.height

    }
}

//extension YYLabel{
//
//    func textH(text:String,font:UIFont, width:CGFloat, numberOfLine:UInt = 0)->CGFloat{
//
//        self.preferredMaxLayoutWidth = width
//        self.lineBreakMode = .byTruncatingTail
//        let attributedText = NSAttributedString(string: text, attributes: [NSFontAttributeName:font])
//        self.attributedText = attributedText
//        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
//        let layout = YYTextLayout(containerSize: maxSize, text: attributedText)
//
//        self.textLayout = layout
//        self.numberOfLines = numberOfLine
//        if let textH = layout?.textBoundingSize.height {
//            return textH
//        }else{
//            return 0
//        }
//
//    }
//
//}


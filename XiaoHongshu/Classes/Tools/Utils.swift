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
    
    static func textH(text:String,font:UIFont, width:CGFloat,numberOfLine:UInt = 0,paragraphSpacing:CGFloat = 5,lineSpacing:CGFloat = 3) -> CGFloat {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle])
        
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
    func textH(text:String,font:UIFont, width:CGFloat,numberOfLine:UInt = 0,textColor:UIColor = UIColor.darkGray,paragraphSpacing:CGFloat = 5,lineSpacing:CGFloat = 3) -> CGFloat {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle])
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

//MARK: - 格式化日期字符串
extension Utils {
    
    static func formatterDate(timeStamp:TimeInterval)->String{
        
        let currentDate = Date()
        let curTimeStamp = currentDate.timeIntervalSince1970
        let stamp = curTimeStamp - timeStamp
        
        if stamp < 60*60*24  { //小于一天
            
            let calendar = Calendar.current
            let date = Date(timeIntervalSince1970: timeStamp)
            let hour = calendar.component(Calendar.Component.hour, from: date)
            let minute = calendar.component(Calendar.Component.minute, from: date)
            let time = String.init(format: "%02d:%02d", hour,minute)
            
            let day = calendar.component(Calendar.Component.day, from: date)
            let curday = calendar.component(Calendar.Component.day, from: currentDate)
            
            if (curday != day) {
                return "昨天\(time)"
            }else {
                return "今天\(time)"
            }
            
        } else if stamp < 60*60*24*365 { //一年内
            
            let calendar = Calendar.current
            let date = Date(timeIntervalSince1970: timeStamp)
            let month = calendar.component(Calendar.Component.month, from: date)
            let day = calendar.component(Calendar.Component.day, from: date)
            let time = String.init(format: "%02d-%02d", month,day)
            return time
            
        } else {//大于一年
            
            let calendar = Calendar.current
            let date = Date(timeIntervalSince1970: timeStamp)
            let year = calendar.component(Calendar.Component.year, from: date)
            let month = calendar.component(Calendar.Component.month, from: date)
            let day = calendar.component(Calendar.Component.day, from: date)
            let time = String.init(format: "%d-%02d-%02d", year,month,day)
            return time
            
        }
        
    }
}

extension Utils{

    static func loadtextInfo(text:String,font:UIFont, width:CGFloat,numberOfLine:UInt = 0,paragraphSpacing:CGFloat = 5,lineSpacing:CGFloat = 3) -> (textH:CGFloat,attributedText:NSAttributedString) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.lineSpacing = lineSpacing
        let attributedText =  NSAttributedString(string: text, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle])
        
        let maxSize = CGSize(width: width, height:CGFloat(MAXFLOAT))
        let textH = TTTAttributedLabel.sizeThatFitsAttributedString(attributedText, withConstraints: maxSize, limitedToNumberOfLines: numberOfLine).height
   
        return (textH,attributedText)
        
    }
}


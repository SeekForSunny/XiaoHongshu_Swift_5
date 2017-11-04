//
//  MineTableViewCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/20.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {
    //图片
    lazy var icoView = UIImageView()
    //标题
    lazy var titleLabel = UILabel()
    //分割线
    lazy var lineView = UIView()
    
    static let  identifier = "MineTableViewCell"
    static func cell(tableView:UITableView) -> MineTableViewCell{
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = MineTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell!.selectionStyle = .none
        return cell as! MineTableViewCell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //布局子控件
    func setupUIContent(){
        
        //添加图标
        addSubview(icoView)
        
        //添加标题
        addSubview(titleLabel)
        
        //添加分割线
        addSubview(lineView)
        
    }
    
    //禁止高亮
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    
    //数据源方法
    func fillter(title:String, ico:String,showLine:Bool){
        
        //图片
        icoView.image = UIImage(named: ico)
        let icoWH = 20*APP_SCALE
        icoView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(SM_MRAGIN_30)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: icoWH, height: icoWH))
        }
        
        //标题
        titleLabel.text = title
        titleLabel.textColor = UIColor.darkText
        titleLabel.font = UIFont.systemFont(ofSize: 15*APP_SCALE)
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(icoView.snp.right).offset(SM_MRAGIN_15)
        }
        
        //是否显示分割线
        lineView.isHidden = !showLine
        lineView.backgroundColor = UIColor.init(r: 235, g: 235, b: 235)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(SM_MRAGIN_30)
            make.right.equalTo(self).offset(-SM_MRAGIN_30)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
}

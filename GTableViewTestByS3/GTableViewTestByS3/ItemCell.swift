//
//  ItemCell.swift
//  GTableViewTestByS3
//
//  Created by 花生 on 6/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var name: String = "" {
        didSet {
            if name != oldValue {
                nameLabel.text = name
            }
        }
    }
    
    var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel(frame: CGRect.zero)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

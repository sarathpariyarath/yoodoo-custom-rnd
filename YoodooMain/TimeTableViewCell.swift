//
//  TimeTableViewCell.swift
//  YoodooMain
//
//  Created by Pardy Panda's New Mac Mini on 27/05/22.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        insideView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

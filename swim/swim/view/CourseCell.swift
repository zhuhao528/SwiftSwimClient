//
//  CourseCell.swift
//  swim
//
//  Created by qing class on 2017/6/14.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var TeacherNameLabel: UILabel!
    @IBOutlet weak var CourseTypeLabel: UILabel!
    @IBOutlet weak var SchoolTimeLabel: UILabel!
    @IBOutlet weak var StudentsNumberLabel: UILabel!
    @IBOutlet weak var StudentsNamesLabel: UILabel!
    @IBOutlet weak var CousreStatusLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CourseCell.swift
//  swim
//
//  Created by qing class on 2017/6/14.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

protocol ManageCourseCellDelegate : class {
    func SureButtonPressed(_ tag: Int)
    func RejectButtonPressed(_ tag: Int)
    func DeleteButtonPressed(_ tag: Int)
}

class ManageCourseCell: UITableViewCell {
    
    @IBOutlet weak var TeacherNameLabel: UILabel!
    @IBOutlet weak var CourseTypeLabel: UILabel!
    @IBOutlet weak var SchoolTimeLabel: UILabel!
    @IBOutlet weak var StudentsNumberLabel: UILabel!
    @IBOutlet weak var StudentsNamesLabel: UILabel!

    @IBOutlet weak var SureButton: UIButton!
   @IBOutlet weak var RejectButton : UIButton!
    @IBOutlet weak var DeleteButton : UIButton!
    
    weak var cellDelegate: ManageCourseCellDelegate?
    
    
    @IBAction func SureButtonPressed(_ sender: UIButton) {
        cellDelegate?.SureButtonPressed(self.tag)
    }
    
    @IBAction func RejectButtonPressed(_ sender: UIButton) {
        cellDelegate?.RejectButtonPressed(self.tag)
    }
    
    @IBAction func DeleteButtonPressed(_ sender: UIButton) {
        cellDelegate?.DeleteButtonPressed(self.tag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sureCourse(_ sender: UIButton) {
        
    }
    
    @IBAction func rejectCourse(_ sender: UIButton) {

    }
    
    @IBAction func deleteCourse(_ sender: UIButton) {
        
    }
}

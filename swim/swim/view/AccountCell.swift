//
//  CourseCell.swift
//  swim
//
//  Created by qing class on 2017/6/14.
//  Copyright © 2017年 qing class. All rights reserved.
//

import UIKit

protocol AccountCellDelegate : class {
    func changePasswordPressed(_ tag: Int)
    func deleteAccountPressed(_ tag: Int)
}

class AccountCell: UITableViewCell {
    
    @IBOutlet weak var AccountLabel: UILabel!
    @IBOutlet weak var TeacherNameLabel: UILabel!
    @IBOutlet weak var CreateTimeLabel: UILabel!

    @IBOutlet weak var ChangePasswordButton: UIButton!
    @IBOutlet weak var DeleteAccountButton : UIButton!
    
    weak var cellDelegate: AccountCellDelegate?

    @IBAction func changePassword(_ sender: UIButton) {
        cellDelegate?.changePasswordPressed(sender.tag)
    }
    
    @IBAction func deleteAccount(_ sender: UIButton) {
        cellDelegate?.deleteAccountPressed(sender.tag)
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

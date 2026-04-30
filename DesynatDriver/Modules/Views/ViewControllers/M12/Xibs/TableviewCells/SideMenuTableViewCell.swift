//
//  SideMenuTableViewCell.swift
//  DesynatDriver
//
//  Created by Akshara Tomar  on 06/04/26.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var termconditionImg: UIImageView!
    @IBOutlet weak var tableviewlabel: UILabel!
    @IBOutlet weak var rightbtnImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        func config(title: String, imagName : String){
            tableviewlabel.text = title
            termconditionImg.image = UIImage(named: imagName)
            self.rightbtnImg.updateForRTL()
    }
    
}

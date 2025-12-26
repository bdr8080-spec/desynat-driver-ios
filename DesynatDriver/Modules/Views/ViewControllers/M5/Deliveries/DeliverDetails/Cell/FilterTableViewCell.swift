//
//  FilterTableViewCell.swift
//  DesynatDriver
//
//  Created by  shailendra singh on 19/12/25.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedType: UIImageView!
    @IBOutlet weak var orderStatusLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func config(_ data: String, _ image: String) {
        orderStatusLbl.text = data
        selectedType.image = UIImage(named: image)
    }
    
}

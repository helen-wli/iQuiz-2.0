//
//  ChoiceTableViewCell.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var choiceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

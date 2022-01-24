//
//  HomeGoalsTblCell.swift
//  WalletWalk
//
//  Created by Sarika scc on 18/01/22.
//

import UIKit

class HomeGoalsTblCell: UITableViewCell {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbl_sliderValue: UILabel!
    
    @IBOutlet weak var bg_view: UIView!
    
    @IBOutlet weak var lbl_leading_const: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.setValue(80, animated: true)
        lbl_leading_const.constant = CGFloat((Float(slider.vWidth - 30) / 100) * slider.value)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

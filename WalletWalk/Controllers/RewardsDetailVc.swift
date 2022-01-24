//
//  RewardsDetailVc.swift
//  WalletWalk
//
//  Created by Sarika scc on 19/01/22.
//

import UIKit

class RewardsDetailVc: UIViewController {

    @IBOutlet weak var lbl_ww: UILabel!
    @IBOutlet weak var img_rewards: UIImageView!
    @IBOutlet weak var lbl_subTitle: UILabel!
    
    var rewardsData : Rewards!
    var subTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img_rewards.cornerRadius = 10

        if rewardsData != nil {
            
            lbl_subTitle.text = subTitle
            lbl_ww.text = rewardsData.ww + " "
            lbl_ww.addImage(imageName: "ic_ww",afterLabel: true)
            img_rewards.image = rewardsData.image
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func click_onBackBtn(_ sender: Any) {
        
        self.goBack()
    }
}

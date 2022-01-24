//
//  RewardsTblCell.swift
//  WalletWalk
//
//  Created by Sarika scc on 19/01/22.
//

import UIKit

class RewardsTblCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var page_control: UIPageControl!
    @IBOutlet weak var bg_view: UIView!
    @IBOutlet weak var coll_rewards: UICollectionView!
    var detailCallBack : ((Int,Int) -> ())?
    
    var arrRewards = [Rewards]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        coll_rewards.delegate = self
        coll_rewards.dataSource = self
        coll_rewards.reloadData()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: collectionview delegate method

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrRewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardsDetailCollCell", for: indexPath)as! RewardsDetailCollCell
        
        let data = arrRewards[indexPath.row]
        cell.lbl_ww.text = data.ww
        cell.img_reward.image = data.image
        cell.cornerRadius = 10
        cell.img_reward.cornerRadius = 10
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      
        page_control.currentPage = indexPath.row
        
        let coll_cell = cell as! RewardsDetailCollCell
        if isImageDark(image: coll_cell.img_reward.image!) {
            
            coll_cell.lbl_ww.textColor = .white
            coll_cell.lbl_ww.addImage(imageName:"ic_ww_white",afterLabel: false)
        }
        else
        {
            coll_cell.lbl_ww.textColor = .black
            coll_cell.lbl_ww.addImage(imageName:"ic_ww",afterLabel: false)
        }
        
        if coll_cell.img_reward.image == UIImage(named: "img_gorillas") {

            coll_cell.lbl_ww.textColor = .white
            coll_cell.lbl_ww.addImage(imageName:"ic_ww_white",afterLabel: false)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: coll_rewards.frame.size.width - 30, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if let callback = detailCallBack{
                
                callback(collectionView.tag,indexPath.row)
            }
        }
    
}

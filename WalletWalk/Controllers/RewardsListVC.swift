//
//  RewardsListVC.swift
//  WalletWalk
//
//  Created by Sarika scc on 19/01/22.
//

import UIKit

struct Rewards {
    
    var image:UIImage!
    var ww:String
    
//    init(){
//
//        ww = ""
//        image = nil
//    }
}

struct RewardsData {
    
    var title:String
    var subtitle:String
    var arrRewards : [Rewards]
    
    init(){
        
        title = ""
        subtitle = ""
        arrRewards = []
    }
}


class RewardsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tbl_rewards: UITableView!
    
    var arrRewardsData = [RewardsData]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUPData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUPData(){
        
        var data = RewardsData()
        data.title = "Featured"
        data.subtitle = "Prices as of 9:41 AM CET"
        data.arrRewards = [Rewards(image: UIImage(named: "img_vanmoof"), ww: "890 WW"),
                           Rewards(image: UIImage(named: "img_gorillas"), ww: "120 WW"),
                           Rewards(image: UIImage(named: "img_netto"), ww: "100 WW"),
                           Rewards(image: UIImage(named: "img_rewe"), ww: "150 WW"),
                           Rewards(image: UIImage(named: "img_tier"), ww: "140 WW")]
        arrRewardsData.append(data)
        
        data.title = "For You"
        data.subtitle = ""
        data.arrRewards = [ Rewards(image: UIImage(named: "img_rewe"), ww: "150 WW"),
                            Rewards(image: UIImage(named: "img_netto"), ww: "100 WW"),
                            Rewards(image: UIImage(named: "img_gorillas"), ww: "120 WW"),
                            Rewards(image: UIImage(named: "img_tier"), ww: "140 WW"),
                            Rewards(image: UIImage(named: "img_vanmoof"), ww: "890 WW")]
        arrRewardsData.append(data)
        
        data.title = "Your friends love these"
        data.subtitle = ""
        data.arrRewards = [Rewards(image: UIImage(named: "img_netto"), ww: "100 WW"),
                           Rewards(image: UIImage(named: "img_rewe"), ww: "150 WW"),
                           Rewards(image: UIImage(named: "img_tier"), ww: "140 WW"),
                           Rewards(image: UIImage(named: "img_vanmoof"), ww: "890 WW"),
                           Rewards(image: UIImage(named: "img_gorillas"), ww: "120 WW")]
        arrRewardsData.append(data)
        
        data.title = "Treat yourself"
        data.subtitle = ""
        data.arrRewards = [Rewards(image: UIImage(named: "img_tier"), ww: "140 WW"),
                           Rewards(image: UIImage(named: "img_vanmoof"), ww: "890 WW"),
                           Rewards(image: UIImage(named: "img_gorillas"), ww: "120 WW"),
                           Rewards(image: UIImage(named: "img_netto"), ww: "100 WW"),
                           Rewards(image: UIImage(named: "img_rewe"), ww: "150 WW")]
        arrRewardsData.append(data)
        
        tbl_rewards.reloadData()
        
        
    }
    
  
    
    //MARK: tableview delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrRewardsData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tbl_rewards.vWidth, height: 40))
        headerView.backgroundColor = .white
        
        let data = arrRewardsData[section]
       
        let lbl_title = UILabel(frame: CGRect(x: 15, y: 0, width: tbl_rewards.vWidth - 50, height: 30))
        lbl_title.text = data.title
        lbl_title.textColor = .black
        lbl_title.font = UIFont(name: Font_Roboto.bold, size: 20)
        headerView.addSubview(lbl_title)
        
        let lblSub_title = UILabel(frame: CGRect(x: headerView.vWidth - 100, y: 5, width: 100, height: 20))
        lblSub_title.text = data.subtitle
        lblSub_title.textColor = hexStringToUIColor(hex: "#152822")
        lblSub_title.font = UIFont(name: Font_Roboto.thin, size: 10)
        lblSub_title.sizeToFit()
        lblSub_title.frame = CGRect(x: headerView.vWidth - (lblSub_title.vWidth + 20), y: 5, width: lblSub_title.vWidth + 10, height: 20)
        headerView.addSubview(lblSub_title)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardsTblCell", for: indexPath)as! RewardsTblCell
        
        let data = arrRewardsData[indexPath.section]
        cell.arrRewards = data.arrRewards
        cell.page_control.currentPage = 0
        cell.page_control.numberOfPages = data.arrRewards.count
        cell.coll_rewards.tag = indexPath.section
        cell.coll_rewards.reloadData()
        
        cell.detailCallBack = { [self] (section,row) in
            
            print("section - row :- ",section," - ",row)
            let vc = storyboard?.instantiateViewController(withIdentifier: "RewardsDetailVc")as! RewardsDetailVc
            vc.rewardsData = arrRewardsData[section].arrRewards[row]
            vc.subTitle = arrRewardsData[section].subtitle
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 210
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    

}

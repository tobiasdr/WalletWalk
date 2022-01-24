//
//  SettingsVC.swift
//  WalletWalk
//
//  Created by Sarika scc on 19/01/22.
//

import UIKit

struct Support{
    
    var title :String
    var image:UIImage!
    
}

class SettingsVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var arrSettings = [Support]()

    @IBOutlet weak var tbl_settings: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupdata()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupdata(){
               
        arrSettings = [Support(title: "About", image: UIImage(named: "app_logo")),Support(title: "White Paper", image: UIImage(named: "ic_paper")),Support(title: "FAQ", image: UIImage(named: "ic_info")),Support(title: "Privacy", image: UIImage(named: "ic_black_lock")),Support(title: "Security", image: UIImage(named: "ic_security")),Support(title: "Coin Price Ticker", image: UIImage(named: "ic_ticker"))]
        
        tbl_settings.reloadData()
    }
    
    //MARK: tableview delegate method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tbl_settings.vWidth, height: 30))
        headerView.backgroundColor = .white
       
        let lbl_title = UILabel(frame: CGRect(x: 15, y: 0, width: tbl_settings.vWidth - 50, height: 30))
        lbl_title.text = section == 0 ? "Support" : "Logins"
        lbl_title.textColor = appTxtColor!
        lbl_title.font = UIFont(name: Font_Roboto.bold, size: 20)
        headerView.addSubview(lbl_title)
        
        if section == 1 {
            
            let lineview = UIView(frame: CGRect(x: 15, y: 40, width: tbl_settings.vWidth - 40, height: 0.8))
            lineview.backgroundColor = appTxtColor!
            headerView.addSubview(lineview)
            
            lbl_title.frame = CGRect(x: 15, y:60 , width: tbl_settings.vWidth - 50, height: 30)
            
        }
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? arrSettings.count : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTblCell", for: indexPath)as! SettingTblCell
            let data = arrSettings[indexPath.row]
            cell.img_option.image = data.image
            cell.lbl_option.text =  data.title
            cell.lbl_option.font = UIFont(name: Font_Roboto.regular, size: 17)
            cell.img_option.contentMode = indexPath.row == 0 ? .scaleAspectFit : .center
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
            cell.textLabel?.text = indexPath.row == 0 ?  "Account" : "Logout"
            cell.textLabel?.font = UIFont(name: Font_Roboto.regular, size: 17)
            cell.textLabel?.textColor = indexPath.row == 0 ? appTxtColor! : .red
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 5 {
            
            if let url = URL(string: "https://pancakeswap.finance/info/token/0x0ba32956dc573764bdee44a7d1997b8ca1f42b9b"){
                
                if UIApplication.shared.canOpenURL(url) {
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            
            self.LogoutPopUp()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? 40 : 35
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 50 : 100
    }
    
    
    
}

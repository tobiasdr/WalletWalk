//
//  HomeVC.swift
//  WalletWalk
//
//  Created by Sarika scc on 18/01/22.
//

import UIKit
import HealthKit
import CoreLocation

var timer = Timer()

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var lbl_balance: UILabel!
    
    @IBOutlet var bg_views: [UIView]!
    @IBOutlet weak var lbl_mining: UILabel!
    @IBOutlet weak var lbl_wws: UILabel!
    @IBOutlet weak var lbl_step: UILabel!
    @IBOutlet weak var tbl_height_const: NSLayoutConstraint!
    
    @IBOutlet weak var tbl_goals: UITableView!
    
    let healthkitStore = HKHealthStore()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_balance.cornerRadius = 10
        bg_views.forEach({$0.cornerRadius = 10})
        btn_play.setTitle("", for: .normal)
        btn_play.setImage(UIImage(named: "ic_play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        lbl_wws.attributedText = setCustomFontToLabel(mainString: "74/100", subString: "/100", fontfamily: Font_Roboto.regular, size: 15)

        getHealthKitPermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if(CLLocationManager.locationServicesEnabled()) {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
            tbl_height_const.constant = tbl_goals.contentSize.height
        }
    }
    
    //MARK: location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print("location coordinates:",locations.last?.coordinate)
    }
    
    func setTimer(){
    
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.getSteps()
        }
    }
   
    //MARK:
    
    func getHealthKitPermission() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            guard HKHealthStore.isHealthDataAvailable() else {
                return
            }

            let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!

            self.healthkitStore.requestAuthorization(toShare: [], read: [stepsCount]) { (success, error) in
                if success {
               
                    print("Permission accept.")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        
                        if defaults.value(forKey: VHkey.startDate) == nil {
                            
                            defaults.setValue(Date(), forKey: VHkey.startDate)
                        }
                        
                        getSteps()
                        self.setTimer()
                    }
                }
                else {
                    if error != nil {
                        print(error ?? "")
                    }
                    print("Permission denied.")
                }
            }
        }
    }
    
    func getSteps(){
        
        self.getTodaysSteps { steps in
            
            print("today steps:",steps)
            DispatchQueue.main.async {
                self.lbl_step.text = String(Int(steps))
            }
        }
        
    }
  
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        var now = Date()
        
        if defaults.value(forKey: VHkey.startDate) != nil {
            
            now = defaults.value(forKey: VHkey.startDate) as? Date ?? Date()
        }
        
//        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: now,
            end: Date(),
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
    
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthkitStore.execute(query)
    }
    
    //MARK: tableview delegate method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
         return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tbl_goals.vWidth, height: 45))
        headerView.backgroundColor = appTxtColor!
        headerView.cornerRadius = 10
        
        if section == 0 {
            
            headerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        
        let lbl_title = UILabel(frame: CGRect(x: 15, y: 8, width: tbl_goals.vWidth - 50, height: 30))
        lbl_title.text = section == 0 ? "Personal Goals" : "Group Goals"
        lbl_title.textColor = .white
        lbl_title.font = UIFont(name: Font_Roboto.bold, size: 15)
        headerView.addSubview(lbl_title)
        
        let btn = UIButton(frame: CGRect(x: headerView.vWidth - 40, y: 10, width: 25, height: 25))
        btn.setImage(UIImage(named: section == 0 ? "ic_plus" : "ic_white_lock"), for: .normal)
        headerView.addSubview(btn)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  section == 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeGoalsTblCell", for: indexPath)as! HomeGoalsTblCell
        
        cell.slider.transform = CGAffineTransform(scaleX: 1, y: 1)
        cell.slider.addTarget(self, action: #selector(changeValueOnSlider), for: .valueChanged)
        cell.bg_view.cornerRadius = 10
        cell.bg_view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        cell.slider.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
    
    @objc func changeValueOnSlider(sender:UISlider){
        
        let index = sender.tag
        
        if let cell = tbl_goals.cellForRow(at: IndexPath(row: index, section: 0)) as? HomeGoalsTblCell{
            cell.lbl_sliderValue.text = "\(Int(sender.value)) %"
            
            UIView.animate(withDuration: 0.2) {
                
                cell.lbl_leading_const.constant = CGFloat((Float(cell.slider.vWidth - 30) / 100) * sender.value)
                
                cell.lbl_sliderValue.layoutIfNeeded()
            }
            cell.lbl_sliderValue.layoutIfNeeded()
        }
        
    }
   
    @IBAction func click_onBtnPlay(_ sender: UIButton) {
        
        let stop_img = UIImage(named: "ic_stop")?.withRenderingMode(.alwaysOriginal)
        let playImg = UIImage(named: "ic_play")?.withRenderingMode(.alwaysOriginal)
        
        if sender.image(for: .normal) == playImg{
            
            sender.setImage(stop_img, for: .normal)
            lbl_mining.text = "Stop walking"
        }
        else
        {
            sender.setImage(playImg, for: .normal)
            lbl_mining.text = "Start walking"
        }
        
    }
    
}

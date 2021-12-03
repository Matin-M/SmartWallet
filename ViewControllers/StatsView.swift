//
//  StatsView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Charts
import UIKit

class StatsView: UIViewController, ChartViewDelegate{
    
    var pieChart = PieChartView()
    var userID: String?
    var purchaseManager: PurchaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        pieChart.delegate = self
        self.userID = StartView.userID
        purchaseManager = PurchaseManager(userID: userID!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        pieChart.center = view.center
        
        view.addSubview(pieChart)
        
        var entries = [PieChartDataEntry]()
        var counts: [String: Int] = [:]
        
        var index: Int = 0
        while index < (purchaseManager?.getCount())! {
            counts[(purchaseManager?.getItem(index: index).category)!] = (counts[(purchaseManager?.getItem(index: index).category)!] ?? 0) + 1
            index += 1
        }
        
        for (key, value) in counts{
            entries.append(PieChartDataEntry(value: Double(value), data: "hi"))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.notifyDataSetChanged()
    }
    
}

//
//  PurchaseCell.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit

class PurchaseCell: UITableViewCell{
    
    //Views
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var cellView: UIView!
    
    //Labels
    @IBOutlet weak var purchaseName: UILabel!
    @IBOutlet weak var purchaseCategory: UILabel!
    @IBOutlet weak var purchaseAmount: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        masterView.backgroundColor = UIColor.clear
        cellView.frame = CGRect(x: cellView.frame.origin.x, y: cellView.frame.origin.y, width: cellView.frame.width, height: cellView.frame.height)
        cellView.layer.cornerRadius = 12.5
        cellView.layer.borderWidth = 2.5
        cellView.layer.borderColor =  UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1.5).cgColor
        cellView.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}

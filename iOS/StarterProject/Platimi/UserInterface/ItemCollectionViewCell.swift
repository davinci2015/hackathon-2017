//
//  ItemCollectionViewCell.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setStyle()
    }

    func setStyle() {
        layer.cornerRadius = DeviceType.isPad ? 4.0 : 2.0
        layer.shadowColor = UIColor.black.withAlphaComponent(0.18).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }

    func setup(index: Int, section: Int) {



        if section == 0 {
            self.image.image = UIImage(named: "\(index)")
            let color = UIColor.colorForUnitNumber(UInt(index))
            self.backgroundColor = color

            var titleText = ""
            switch index {
            case 1:
                titleText = "Održiva zajednica"
            case 2:
                titleText = "Zdravlje"
            case 3:
                titleText = "Život u vodi"
            case 4:
                titleText = "Klimatske promjene"
            case 5:
                titleText = "Život na zemlji"
            case 6:
                titleText = "Odgovrna potrošnja"
            case 7:
                titleText = "Čista energija"
            case 8:
                titleText = "Čista voda"
            default: titleText = "Glad"
            }
            
            title.text = titleText

        } else {
            self.image.image = UIImage(named: "\(index + 4)")
            let color = UIColor.colorForUnitNumber(UInt(index + 4))
            self.backgroundColor = color

            var index2 = index + 4

            var titleText = ""
            switch index2 {
            case 1:
                titleText = "Održiva zajednica"
            case 2:
                titleText = "Zdravlje"
            case 3:
                titleText = "Život u vodi"
            case 4:
                titleText = "Klimatske promjene"
            case 5:
                titleText = "Život na zemlji"
            case 6:
                titleText = "Odgovrna potrošnja"
            case 7:
                titleText = "Čista energija"
            case 8:
                titleText = "Čista voda"
            default: titleText = "Glad"
            }

            title.text = titleText

        }







    }

}

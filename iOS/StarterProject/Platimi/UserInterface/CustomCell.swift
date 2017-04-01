//
//  CustomCell.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var model: Pokemon? {
        didSet {
            self.updateUI()
        }
    }

    private func updateUI() {
        self.pokemonName.text = model?.name ?? ""
    }
}

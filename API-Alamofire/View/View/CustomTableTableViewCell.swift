//
//  CustomTableTableViewCell.swift
//  API-Alamofire
//
//  Created by Reserveit Support on 25/3/23.
//

import UIKit

class CustomTableTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(value: UserInfo) {
        imgView.loadImageFromUrl(value.img)
        id.text = "ID: \(value.id)"
        name.text = "Name: \(value.name)"
    }
    
}

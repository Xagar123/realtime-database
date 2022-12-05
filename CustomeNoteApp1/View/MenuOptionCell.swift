//
//  MenuOptionCell.swift
//  Side Menu Bar prog
//
//  Created by Admin on 26/11/22.
//

import UIKit

class MenuOptionCell: UITableViewCell {

   // MARK: - properties
  
    var iconImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
       // iv.backgroundColor = .blue
        return iv
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.text = "sample text"
        return lable
    }()
    
    
  // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .darkGray
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(descriptionLable)
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLable.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
//        descriptionLable.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        descriptionLable.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - handler

}

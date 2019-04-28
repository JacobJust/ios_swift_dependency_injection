//
//  ElementTableCell.swift
//  DependencyInjectiontest
//
//  Created by Jacob Just on 28/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

import Foundation
import UIKit

class ElementTableCell: UITableViewCell {

    static let reuseIdentifier = "ElementTableCell"
    
    var elementTitle: UILabel!
    var elementDescription: UILabel!
    
    var element: Element? {
        didSet {
            populateData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadUI()
    }
    
    private func loadUI() {
        elementTitle = contentView.addLargeTitle()
        elementDescription = contentView.addMediumTitle()
        
        elementTitle.marginTop(10)
            .marginLeft(10)
            .marginRight(-10)
            .setHeight(30)
    
        elementDescription.marginTopFromView(margin: 10, view: elementTitle)
            .marginLeft(10)
            .marginRight(-10)
            .setHeight(30)
            .marginBottom(-10)
    }
    
    private func populateData() {
        guard let element = self.element else {
            //Log error
            return
        }
        
        elementTitle.text = element.title
        elementDescription.text = element.description
    }
}

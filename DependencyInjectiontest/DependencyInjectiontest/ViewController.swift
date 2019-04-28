//
//  ViewController.swift
//  DependencyInjectiontest
//
//  Created by Jacob Just on 27/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BackendServices {

    private let disposeBag = DisposeBag()

    private var elements: [Element] = []
    
    public var table: UITableView!
    
    public var button: UIButton!
    
    public lazy var elementService: ElementService = {
        getElementService()
    }()
    
    /*
     UI doesn´t matter in this example,
     but notice the simplicity compared to storyboards,
     and think code review, for ui changes ;-)
     */
    override func viewWillAppear(_ animated: Bool) {
        let mainView = view.addView()
        mainView.anchorFillSuperview()
        mainView.backgroundColor = UIColor.white

        let title = mainView.addLargeTitle(text: "Add an item through service")
        title.textColor(UIColor.blue)
            .marginTop(40)
            .anchorCenterXToSuperview()
        
        button = mainView.addButtonWithRoundBorder(text: "+", backgroundColor: UIColor.white, foregroundColor: UIColor.blue)
        button.marginTopFromView(margin: 40, view: title)
            .anchorCenterXToSuperview()
            .setWidth(80)
            .setHeight(80)
    
        table = mainView.addTableVIew()
        table.withDelegate(self)
            .withSource(self)
            .with(cell: ElementTableCell.self, identifier: ElementTableCell.reuseIdentifier)
            .marginTopFromView(margin: 20, view: button)
            .marginBottom(0)
            .marginLeft(0)
            .marginRight(0)
        
        button.addTarget(self, action: #selector(addItem), for: .touchUpInside)

        reload()
    }
    
    private func reload() {
        elementService.getElements().subscribe(onNext: { [weak self] (result) in
                self?.elements = result
                self?.table?.reloadData()
            }).disposed(by: disposeBag)
    }
    
    @objc func addItem() {
        elementService.addElement(title: "new item", description: "with description").subscribe(onNext: { [weak self] (result) in
                self?.reload()
            }).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ElementTableCell.reuseIdentifier) as? ElementTableCell {
            cell.element = elements[indexPath.row]
            return cell
        }

        //LOG
        return UITableViewCell()
    }
}


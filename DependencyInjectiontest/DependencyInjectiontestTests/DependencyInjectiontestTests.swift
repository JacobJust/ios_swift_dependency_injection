//
//  DependencyInjectiontestTests.swift
//  DependencyInjectiontestTests
//
//  Created by Jacob Just on 27/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

@testable import DependencyInjectiontest

import XCTest
import Nimble
import Cuckoo
import Foundation
import RxSwift

class DependencyInjectiontestTests: XCTestCase {

    var mock: MockElementService!
    var viewController: ViewController!
    
    override func setUp() {
        mock = MockElementService()
        backedServiceInstances.elementService = mock
    }
    
    func createViewController() {
        viewController = ViewController()
        viewController.elementService = mock
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
        _ = viewController.view
    }

    func testRenderCells() {
        let elements: [Element] = [Element(title: "title 1", description: "description 1"),
                                   Element(title: "title 2", description: "description 2")]
        
        stub(mock) { stub in
            when(stub.getElements()).thenReturn(Observable.just(elements))
        }
        
        createViewController()
        
        expect(self.viewController.table.numberOfRows(inSection: 0)).to(equal(2))

        expect(self.getCellAt(index: 0).elementTitle.text).to(equal(elements[0].title))
        expect(self.getCellAt(index: 0).elementDescription.text).to(equal(elements[0].description))

        expect(self.getCellAt(index: 1).elementTitle.text).to(equal(elements[1].title))
        expect(self.getCellAt(index: 1).elementDescription.text).to(equal(elements[1].description))
    }
    
    func testAddElement() {
        stub(mock) { stub in
            when(stub.getElements()).thenReturn(Observable.just([]))
            when(stub.addElement(title: any(), description: any())).thenReturn(Observable.empty())
        }
        
        createViewController()
        
        viewController.button.sendActions(for: .touchUpInside)
        
        let titleCaptor = ArgumentCaptor<String>()
        let descriptionCaptor = ArgumentCaptor<String>()
        verify(mock, times(1)).addElement(title: titleCaptor.capture(), description: descriptionCaptor.capture())
        
        expect(titleCaptor.value).to(equal("new item"))
        expect(descriptionCaptor.value).to(equal("with description"))
    }
    
    func getCellAt(index: Int) -> ElementTableCell {
        let res =  viewController.tableView(viewController.table, cellForRowAt: IndexPath(row: index, section: 0))
        return res as! ElementTableCell
    }
}

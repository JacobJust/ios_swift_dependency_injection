//
//  ElementService.swift
//  DependencyInjectiontest
//
//  Created by Jacob Just on 27/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

import Foundation
import RxSwift

/*
 The contract for the element service, can be mocked (with cuckoo) or implemented.
*/
public protocol ElementService {
    
    func addElement(title: String, description: String) -> Observable<Void>
    
    func getElements() -> Observable<[Element]>
}


//
//  ElementServiceImpl.swift
//  DependencyInjectiontest
//
//  Created by Jacob Just on 27/04/2019.
//  Copyright © 2019 Jacob Just. All rights reserved.
//

import Foundation
import RxSwift

class ElementServiceImpl: ElementService {
    
    private var elements: [Element] = []
    
    init() {
        elements.append(Element(title: "an element", description: "random description"))
        elements.append(Element(title: "another element", description: "some description"))
        elements.append(Element(title: "last element", description: "other description"))
    }
    
    func addElement(title: String, description: String) -> Observable<Void> {
        return Observable.create { observer in
            //Delay, to make the service slow
            _ = Observable.of(true).delay(1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] (result) in
                self?.elements.append(Element(title: title, description: description))
                observer.onNext(())
                observer.onCompleted()
            })
            
            return Disposables.create()
        }
    }
    
    func getElements() -> Observable<[Element]> {
        return Observable.just(elements)
    }
}

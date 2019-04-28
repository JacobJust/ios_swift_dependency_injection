# ios_swift_dependency_injection
Dependency injection by pattern

Swift dependency injection is difficult compared to the possibilies in Java EE and Android, this project demonstrates how to handle this with a pattern, and with cuckoo we get nice testable mocks (like with mockito).

Example of the simple tests:

    func testRenderCells() {
        let elements: [Element] = [Element(title: "title 1", description: "description 1"),
                                   Element(title: "title 2", description: "description 2")]
        
        stub(mock) { stub in
            when(stub.getElements()).thenReturn(Observable.just(elements))
        }
        
        createViewController()
        
        expect(self.viewController.table.numberOfRows(inSection: 0)).to(equal(2))
    }


Todo: 
 - make the injection / providing part generic, to avoid boilerplate code, when adding more services.
 - CI: https://travis-ci.com

/*
 Some boilerplatecode here, but in one file, and realy testable
 */

import Foundation
import RxSwift

public class BackedServiceInstances {
    public lazy var elementService: ElementService = {
        ElementServiceImpl()
    }()
}

public let backedServiceInstances = BackedServiceInstances()

public protocol BackendServices {
    func getElementService() -> ElementService
}

public extension BackendServices {
    func getElementService() -> ElementService {
        return backedServiceInstances.elementService
    }
}

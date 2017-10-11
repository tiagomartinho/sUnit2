typealias TestClosure = (TestCase) throws -> Void

internal var CurrentTestCase: TestCase?

class TestCase {
    
    let testClosure: TestClosure
    
    var continueAfterFailure = true
    
    init(_ testClosure: @escaping TestClosure) {
        self.testClosure = testClosure
    }
    
    func run() {
        CurrentTestCase = self
        do {
            try testClosure(self)
        } catch {
        }
        CurrentTestCase = nil
    }
    
    func recordFailure() {
        if !continueAfterFailure {
            fatalError("Terminating execution due to test failure")
        }
    }
}

func test<T: TestCase>(_ testFunc: @escaping (T) -> () throws -> Void) -> TestClosure {
    return { testCaseType in
        guard let testCase = testCaseType as? T else {
            fatalError("Attempt to invoke test on class \(T.self) with incompatible instance type \(type(of: testCaseType))")
        }
        try testFunc(testCase)()
    }
}

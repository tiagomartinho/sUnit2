typealias TestClosure = (TestCase) throws -> Void

class TestCase {
    
    let testClosure: TestClosure
    
    init(_ testClosure: @escaping TestClosure) {
        self.testClosure = testClosure
    }
    
    func run() {
        do {
            try testClosure(self)
        } catch {
        }
    }
}

class WasRun: TestCase {
    
    var log = ""
    
    func testMethod() {
        log += "testMethod"
    }
}

private func test<T: TestCase>(_ testFunc: @escaping (T) -> () throws -> Void) -> TestClosure {
    return { testCaseType in
        guard let testCase = testCaseType as? T else {
            fatalError("Attempt to invoke test on class \(T.self) with incompatible instance type \(type(of: testCaseType))")
        }
        try testFunc(testCase)()
    }
}

class TestCaseTest: TestCase {
    func testTemplateMethod() {
        let testToRun = WasRun(test(WasRun.testMethod))
        _ = testToRun.run()
        assert("testMethod" == testToRun.log)
    }
}

TestCaseTest(test(TestCaseTest.testTemplateMethod)).run()

class TestCase {
    
    let testName: String
    let testClosure: (TestCase) -> Void
    
    init(_ testName: String, _ testClosure: @escaping (TestCase) -> Void) {
        self.testName = testName
        self.testClosure = testClosure
    }
    
    func run() {
        testClosure(self)
    }
}

class WasRun: TestCase {
    
    var log = ""
    
    func testMethod() {
        log += "testMethod"
    }
}

func test<T: TestCase>(_ testFunc: @escaping (T) -> () -> Void) -> (TestCase) -> Void {
    return { testCaseType in
        guard let testCase = testCaseType as? T else {
            fatalError("Attempt to invoke test on class \(T.self) with incompatible instance type \(type(of: testCaseType))")
        }
        testFunc(testCase)()
    }
}

class TestCaseTest: TestCase {
    func testTemplateMethod() {
        let testToRun = WasRun("testMethod", test(WasRun.testMethod))
        _ = testToRun.run()
        assert("testMethod" == testToRun.log)
    }
}

TestCaseTest("testTemplateMethod", test(TestCaseTest.testTemplateMethod)).run()

struct TestResult {
    let summary: String
}

class TestCase {
    
    let testName: String
    let testClosure: (TestCase) -> Void
    
    init(_ testName: String, _ testClosure: @escaping (TestCase) -> Void) {
        self.testName = testName
        self.testClosure = testClosure
    }
    
    func run() -> TestResult {
        setUp()
        testClosure(self)
        tearDown()
        return TestResult(summary: "1 run, 0 failed")
    }
    
    func setUp() {}
    
    func tearDown() {}
}

class WasRun: TestCase {
    
    var log = ""
    
    override func setUp() {
        log += "setUp "
    }
    
    override func tearDown() {
        log += "tearDown "
    }
    
    func testMethod() {
        log += "testMethod "
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
        assert("setUp testMethod tearDown " == testToRun.log)
    }
    
    func testResult() {
        let testToRun = WasRun("testMethod", test(WasRun.testMethod))
        let result = testToRun.run()
        assert("1 run, 0 failed" == result.summary)
    }
}

_ = TestCaseTest("testTemplateMethod", test(TestCaseTest.testTemplateMethod)).run()
_ = TestCaseTest("testResult", test(TestCaseTest.testResult)).run()

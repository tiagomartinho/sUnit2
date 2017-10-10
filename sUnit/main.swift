class TestCase {
    
    let testName: String
    let testClosure: (TestCase) -> Void
    
    init(_ testName: String, _ testClosure: @escaping (TestCase) -> Void) {
        self.testName = testName
        self.testClosure = testClosure
    }
    
    func setUp() {
    }
    
    func run() {
        setUp()
        testClosure(self)
    }
}

class WasRun: TestCase {
    
    var wasSetUp = false
    var wasRun = false
    
    override func setUp() {
        wasSetUp = true
    }
    
    func testMethod() {
        wasRun = true
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
    
    func testRunning() {
        let testToRun = WasRun("testMethod", test(WasRun.testMethod))
        assert(!testToRun.wasRun)
        testToRun.run()
        assert(testToRun.wasRun)
    }
    
    func testSetUp() {
        let testToRun = WasRun("testMethod", test(WasRun.testMethod))
        testToRun.run()
        assert(testToRun.wasSetUp)
    }
}

TestCaseTest("testRunning", test(TestCaseTest.testRunning)).run()
TestCaseTest("testSetUp", test(TestCaseTest.testSetUp)).run()

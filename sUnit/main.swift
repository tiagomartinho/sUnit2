class TestContinueAfterFailure: TestCase {
    
    var log = ""
    
    func testContinueAfterFailure() {
        log = ""
        continueAfterFailure = true
        log += "first "
        Assert(false)
        log += "second"
    }
    
    func testDoesNotContinueAfterFailure() {
        log = ""
        continueAfterFailure = false
        log += "first "
        Assert(false)
        log += "second"
    }
}

class TestCaseTest: TestCase {
    func testContinueAfterFailureMethod() {
        let testToRun = TestContinueAfterFailure(test(TestContinueAfterFailure.testContinueAfterFailure))
        _ = testToRun.run()
        assert("first second" == testToRun.log)
    }
    
    func testDoesNotContinueAfterFailureMethod() {
        let testToRun = TestContinueAfterFailure(test(TestContinueAfterFailure.testDoesNotContinueAfterFailure))
        _ = testToRun.run()
        assert("first" == testToRun.log)
    }
}

TestCaseTest(test(TestCaseTest.testContinueAfterFailureMethod)).run()
TestCaseTest(test(TestCaseTest.testDoesNotContinueAfterFailureMethod)).run()

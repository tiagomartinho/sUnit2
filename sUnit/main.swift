class WasRun {
    
    var wasRun = false
    
    init(_ testName: String) {
    }
    
    func testMethod() {
        wasRun = true
    }
}

let test = WasRun("testMethod")
print(test.wasRun)
test.testMethod()
print(test.wasRun)

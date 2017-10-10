class WasRun {
    
    let wasRun = false
    
    init(_ testName: String) {
    }
    
    func testMethod() {
    }
}

let test = WasRun("testMethod")
print(test.wasRun)
test.testMethod()
print(test.wasRun)

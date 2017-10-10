class WasRun {
    
    var wasRun = false
    
    init(_ testName: String) {
    }
    
    func run() {
        testMethod()
    }
    
    func testMethod() {
        wasRun = true
    }
}

let test = WasRun("testMethod")
print(test.wasRun)
test.run()
print(test.wasRun)

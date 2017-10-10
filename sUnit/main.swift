class WasRun {
    
    let testName: String
    let testClosure: ((WasRun) -> () -> ())
    
    var wasRun = false
    
    init(_ testName: String, _ testClosure: @escaping ((WasRun) -> () -> ())) {
        self.testName = testName
        self.testClosure = testClosure
    }
    
    func run() {
        testClosure(self)()
    }
    
    func testMethod() {
        wasRun = true
    }
}

let test = WasRun("testMethod", WasRun.testMethod)
print(test.wasRun)
test.run()
print(test.wasRun)

enum Assertion {
    case `true`
}

enum AssertionResult {
    case success
    case expectedFailure(String?)
    case unexpectedFailure(Swift.Error)
}

func Assert(_ expression: @autoclosure () throws -> Bool) throws {
    try EvaluateAssertion(.`true`) {
        let value = try expression()
        if value {
            return .success
        } else {
            return .expectedFailure(nil)
        }
    }
}

func EvaluateAssertion(_ assertion: Assertion, expression: () throws -> AssertionResult) throws {
    let result: AssertionResult
    do {
        result = try expression()
    } catch {
        result = .unexpectedFailure(error)
    }
    switch result {
    case .success:
        return
    default:
        if let currentTestCase = CurrentTestCase {
            try currentTestCase.recordFailure()
        }
    }
}

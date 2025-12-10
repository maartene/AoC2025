import Testing
@testable import Day10

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite struct `to get the first star on day 10` {
    @Test func `the fewest number of button presses for an example machine should be 2`() {
        let machine = Machine(
            lights: [false, true, true, false],
            rules: [
                [3], [1,3],[2],[2,3],[0,2],[0,1]
            ]
        )
        
        let result = machine.minimumButtonPresses()
        
        #expect(result == 2)
    }
}

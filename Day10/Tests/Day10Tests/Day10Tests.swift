import Testing
@testable import Day10

let exampleInput =
"""
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
"""

@Suite struct `to get the first star on day 10` {
    @Test func `the fewest number of button presses for an example machine should be 2`() {
        let machine = Machine(
            lights: [false, true, true, false],
            rules: [
                [3], [1,3],[2],[2,3],[0,2],[0,1]
            ],
            joltageRequirements: [3,5,4,7]
        )
        
        let result = machine.minimumButtonPressesToMeetLightRequirements()
        
        #expect(result == 2)
    }
    
    @Test func `construct a machine from a string`() {
        let expectedMachine = Machine(
            lights: [false, true, true, false],
            rules: [
                [3], [1,3],[2],[2,3],[0,2],[0,1]
            ],
            joltageRequirements: [3,5,4,7]
        )
        
        let machine = Machine("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}")
        
        #expect(machine == expectedMachine)
    }
    
    @Test func `the fewest number of example presses in the example input should be 7`() {
        #expect(part1(in: exampleInput) == 7)
    }
}

@Suite struct `to get the second star on day 10` {
    @Test(arguments: [
        ("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}", 10)
    ]) func `the fewest number of presses for the machines should be as expected`(testcase: (machineString: String, expectedPressCount: Int)) {
        let machine = Machine(testcase.machineString)
        
        #expect(machine.minimumButtonPressesToMeetJoltageRequirement() == 10)
    }
}

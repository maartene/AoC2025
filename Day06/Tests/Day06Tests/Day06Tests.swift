import Testing
@testable import Day06

let exampleInput =
"""
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
"""

@Suite struct `to get the first star on day 06` {
    @Test func `the total of all math problem answers summed up for the example input should be 4277556`() {
        #expect(sumOfMathProblems(in: exampleInput) == 4277556)
    }
    
    @Test func `the total of all math problem answers summed up for the actual input should be 5873191732773`() {
        #expect(sumOfMathProblems(in: input) == 5873191732773)
    }
}

import Testing
@testable import Day06

let exampleInput =
"123 328  51 64 \n" +
" 45 64  387 23 \n" +
"  6 98  215 314\n" +
"*   +   *   +  "
@Suite struct `to get the first star on day 06` {
    @Test func `the total of all math problem answers summed up for the example input should be 4277556`() {
        #expect(sumOfMathProblems(in: exampleInput) == 4277556)
    }
    
    @Test func `the total of all math problem answers summed up for the actual input should be 5873191732773`() {
        #expect(sumOfMathProblems(in: input) == 5873191732773)
    }
}

@Suite struct `to get the second star on day 06` {
    @Test func `the total of all math problem answers summed up for the example input should be 3263827`() {
        #expect(sumOfMathProblemsRightToLeft(in: exampleInput) == 3263827)
    }
    
    @Test func `the total of all math problem answers summed up for the actual input should be 11386445308378`() {
        #expect(sumOfMathProblemsRightToLeft(in: input) == 11386445308378)
    }
}


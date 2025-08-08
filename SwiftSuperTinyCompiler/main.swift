//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

// MARK: - Test the Compiler

let input = "(add 2 (subtract 4 2))"
let output = compiler(input: input)
let expectedOutput = "add(2, subtract(4, 2))"
print("Input: \(input)")
print("Output: \(output)")
print("Expected Output: \(expectedOutput)")
if output == expectedOutput { 
    print("Test Passed ✅")
} else {
    print("Test Failed ❌")
}
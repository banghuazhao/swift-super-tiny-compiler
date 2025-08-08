# Swift Super Tiny Compiler

A Swift implementation of a super tiny compiler that demonstrates the fundamental concepts of compiler design. This project transforms LISP-like function calls into JavaScript-style function calls.

## Overview

This compiler takes a simple LISP-like syntax and converts it into Swift-style function calls. It demonstrates the four main phases of compilation:

1. **Tokenization** - Breaking input into tokens
2. **Parsing** - Converting tokens into an Abstract Syntax Tree (AST)
3. **Transformation** - Converting the AST into a different format
4. **Code Generation** - Converting the transformed AST into output code

## Example

**Input (LISP-like):**
```
(add 2 (subtract 4 2))
```

**Output (Swift-style):**
```
add(2, subtract(4, 2))
```

## Architecture

The compiler is organized into several key components that work together to transform LISP-like syntax into Swift-style function calls:

### 1. Tokenizer (`tokenizer.swift`)
- Breaks the input string into tokens
- Recognizes parentheses, numbers, strings, and identifiers
- Handles whitespace and different character types

### 2. Parser (`parser.swift`)
- Converts tokens into an Abstract Syntax Tree (AST)
- Defines AST node types: Program, CallExpression, NumberLiteral, StringLiteral, Identifier
- Implements recursive descent parsing

### 3. Transformer (`transformer.swift`)
- Transforms the AST from LISP-style to Swift-style
- Uses the Visitor pattern to traverse and transform nodes
- Converts CallExpression nodes to Swift function call format using SwiftASTNode structures

### 4. Code Generator (`codeGenerator.swift`)
- Converts the transformed AST back into code
- Generates Swift-style function calls without semicolons

### 5. Traverser (`traverser.swift`)
- Implements the Visitor pattern for AST traversal
- Allows for different operations during tree traversal

## Project Structure

```
SwiftSuperTinyCompiler/
├── main.swift           # Entry point and test runner
├── compiler.swift       # Main compiler orchestration
├── tokenizer.swift      # Tokenization logic
├── parser.swift         # Parsing and AST creation
├── transformer.swift    # AST transformation
├── traverser.swift      # AST traversal utilities
└── codeGenerator.swift  # Code generation
```

## How to Run

1. Open the project in Xcode
2. Build and run the project
3. The main function will execute a test case and display the results

## Test Case

The compiler includes a built-in test that demonstrates the transformation:

```swift
let input = "(add 2 (subtract 4 2))"
let output = compiler(input: input)
let expectedOutput = "add(2, subtract(4, 2))"
```

## Supported Syntax

The compiler supports a simple LISP-like syntax:

- **Function calls**: `(functionName arg1 arg2 ...)`
- **Numbers**: `123`, `456`
- **Strings**: `"hello world"`
- **Nested expressions**: `(add 2 (subtract 4 2))`

## Compiler Pipeline

1. **Input**: `"(add 2 (subtract 4 2))"`
2. **Tokens**: `[paren, name, number, paren, name, number, number, paren, paren]`
3. **AST**: Nested CallExpression nodes with parameters
4. **Transformed AST**: Swift-style AST with callee and arguments
5. **Output**: `"add(2, subtract(4, 2))"`

## Learning Objectives

This project demonstrates:

- **Lexical Analysis**: How to break source code into tokens
- **Syntax Analysis**: How to build an Abstract Syntax Tree
- **AST Transformation**: How to convert between different AST formats (LISP-style to Swift-style)
- **Code Generation**: How to generate Swift code from an AST
- **Visitor Pattern**: How to traverse and operate on tree structures
- **Swift-Specific Features**: How to implement Swift-style AST structures and code generation

## Dependencies

- Swift 5.0+
- Foundation framework
- Xcode (for building and running)

## License

Copyright Apps Bay Limited. All rights reserved.

## Author

Created by Banghua Zhao on 08/08/2025

---

This project is inspired by [The Super Tiny Compiler](https://github.com/jamiebuilds/the-super-tiny-compiler) by Jamie Kyle, which demonstrates compiler concepts in JavaScript. This Swift implementation extends the original concept by generating Swift-style function calls instead of JavaScript, serving as an educational tool for understanding compiler design principles in Swift.

## Related Projects

- **Original JavaScript Implementation**: [jamiebuilds/the-super-tiny-compiler](https://github.com/jamiebuilds/the-super-tiny-compiler) - The original JavaScript version that inspired this project
- **Swift Implementation**: [banghuazhao/swift-super-tiny-compiler](https://github.com/banghuazhao/swift-super-tiny-compiler) - This Swift port that generates Swift-style function calls

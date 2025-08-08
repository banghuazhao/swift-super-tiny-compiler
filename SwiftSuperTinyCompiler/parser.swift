//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

// MARK: - AST Node Types

enum NodeType: String {
    case program = "Program"
    case callExpression = "CallExpression"
    case numberLiteral = "NumberLiteral"
    case stringLiteral = "StringLiteral"
    case identifier = "Identifier"
    case expressionStatement = "ExpressionStatement"
}

// MARK: - AST Node Protocol

protocol ASTNode {
    var type: NodeType { get }
}

// MARK: - AST Node Structures

struct Program: ASTNode {
    let type: NodeType = .program
    let body: [ASTNode]
}

struct CallExpression: ASTNode {
    let type: NodeType = .callExpression
    let name: String
    let params: [ASTNode]
}

struct NumberLiteral: ASTNode {
    let type: NodeType = .numberLiteral
    let value: String
}

struct StringLiteral: ASTNode {
    let type: NodeType = .stringLiteral
    let value: String
}

struct Identifier: ASTNode {
    let type: NodeType = .identifier
    let name: String
}

struct ExpressionStatement: ASTNode {
    let type: NodeType = .expressionStatement
    let expression: CallExpression
}

// MARK: - Parser

func parser(tokens: [Token]) -> Program {
    var current = 0

    func walk() -> ASTNode {
        let token = tokens[current]

        // Handle number tokens
        if token.type == .number {
            current += 1
            return NumberLiteral(value: token.value)
        }

        // Handle string tokens
        if token.type == .string {
            current += 1
            return StringLiteral(value: token.value)
        }

        // Handle CallExpressions (parentheses)
        if token.type == .paren && token.value == "(" {
            // Skip the opening parenthesis
            current += 1

            // Get the function name
            let token = tokens[current]
            let node = CallExpression(
                name: token.value,
                params: []
            )

            // Skip the function name
            current += 1

            // Collect parameters until we hit a closing parenthesis
            var params: [ASTNode] = []
            while current < tokens.count {
                let token = tokens[current]

                // Check for closing parenthesis
                if token.type == .paren && token.value == ")" {
                    current += 1
                    break
                }

                // Recursively parse the parameter
                params.append(walk())
            }

            // Create a new CallExpression with the collected parameters
            return CallExpression(
                name: node.name,
                params: params
            )
        }

        // Unknown token type
        fatalError("Unknown token type: \(token.type)")
    }

    // Create the AST with a Program node
    var body: [ASTNode] = []

    // Parse all tokens into AST nodes
    while current < tokens.count {
        body.append(walk())
    }

    return Program(body: body)
}

//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

// MARK: - Code Generator

func codeGenerator(node: SwiftASTNode) -> String {
    
    switch node.type {
    case .program:
        if let program = node as? SwiftProgram {
            return program.body.map { codeGenerator(node: $0) }.joined(separator: "\n")
        }
        
    case .expressionStatement:
        if let exprStmt = node as? SwiftExpressionStatement {
            return codeGenerator(node: exprStmt.expression)
        }
        
    case .callExpression:
        if let callExpr = node as? SwiftCallExpression {
            let callee = codeGenerator(node: callExpr.callee)
            let arguments = callExpr.arguments.map { codeGenerator(node: $0) }.joined(separator: ", ")
            return callee + "(" + arguments + ")"
        }
        
    case .identifier:
        if let identifier = node as? SwiftIdentifier {
            return identifier.name
        }
        
    case .numberLiteral:
        if let numLit = node as? NumberLiteral {
            return numLit.value
        }
        
    case .stringLiteral:
        if let strLit = node as? StringLiteral {
            return "\"" + strLit.value + "\""
        }
    }
    
    fatalError("Unknown node type: \(node.type)")
}

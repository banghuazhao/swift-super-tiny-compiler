//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

// MARK: - Swift-style AST Structures

struct SwiftCallExpression {
    let type: NodeType = .callExpression
    let callee: SwiftIdentifier
    let arguments: [SwiftASTNode]
}

struct SwiftIdentifier {
    let type: NodeType = .identifier
    let name: String
}

struct SwiftExpressionStatement {
    let type: NodeType = .expressionStatement
    let expression: SwiftCallExpression
}

struct SwiftProgram {
    let type: NodeType = .program
    let body: [SwiftASTNode]
}

// MARK: - Swift AST Node Protocol

protocol SwiftASTNode {
    var type: NodeType { get }
}

extension SwiftCallExpression: SwiftASTNode {}
extension SwiftIdentifier: SwiftASTNode {}
extension SwiftExpressionStatement: SwiftASTNode {}
extension SwiftProgram: SwiftASTNode {}
extension NumberLiteral: SwiftASTNode {}
extension StringLiteral: SwiftASTNode {}

// MARK: - Transformer Visitor

class TransformerVisitor: Visitor {
    private var newAst: SwiftProgram
    private var callExpressionStack: [SwiftCallExpression]
    private var programBody: [SwiftASTNode]
    
    init() {
        self.newAst = SwiftProgram(body: [])
        self.callExpressionStack = []
        self.programBody = []
    }
    
    func enter(_ node: ASTNode, parent: ASTNode?) {
        switch node.type {
        case .numberLiteral:
            if let numLit = node as? NumberLiteral {
                addToCurrentContext(NumberLiteral(value: numLit.value))
            }
            
        case .stringLiteral:
            if let strLit = node as? StringLiteral {
                addToCurrentContext(StringLiteral(value: strLit.value))
            }
            
        case .callExpression:
            if let callExpr = node as? CallExpression {
                // Create new CallExpression with callee
                let newCallExpr = SwiftCallExpression(
                    callee: SwiftIdentifier(name: callExpr.name),
                    arguments: []
                )
                
                // Push to stack
                callExpressionStack.append(newCallExpr)
                
                // Only add to program body if it's a top-level call
                if parent?.type != .callExpression {
                    let expression = SwiftExpressionStatement(expression: newCallExpr)
                    programBody.append(expression)
                }
            }
        case .program:
            break
            
        default:
            print("  Unknown node type: \(node.type.rawValue)")
            break
        }
    }
    
    func exit(_ node: ASTNode, parent: ASTNode?) {
        if node.type == .callExpression {
            // Pop from stack
            if !callExpressionStack.isEmpty {
                let completedCallExpr = callExpressionStack.removeLast()
                
                // If this was a nested call expression, add it to the parent's arguments
                if parent?.type == .callExpression {
                    addToCurrentContext(completedCallExpr)
                }
            }
        }
    }
    
    private func addToCurrentContext(_ node: SwiftASTNode) {
        if !callExpressionStack.isEmpty {
            // Add to the current call expression's arguments
            let currentCallExpr = callExpressionStack.last!
            let updatedCallExpr = SwiftCallExpression(
                callee: currentCallExpr.callee,
                arguments: currentCallExpr.arguments + [node]
            )
            
            // Update the stack
            callExpressionStack[callExpressionStack.count - 1] = updatedCallExpr
            
            // Update the program body if this is a top-level call
            if callExpressionStack.count == 1 && !programBody.isEmpty {
                let expressionStatement = SwiftExpressionStatement(expression: updatedCallExpr)
                programBody[programBody.count - 1] = expressionStatement
            }
            
        } else {
            // Add directly to program body
            programBody.append(node)
        }
    }
    
    func getTransformedAST() -> SwiftProgram {
        let result = SwiftProgram(body: programBody)
        return result
    }
}

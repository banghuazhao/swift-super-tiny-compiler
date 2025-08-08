//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

// MARK: - Visitor Protocol

protocol Visitor {
    func enter(_ node: ASTNode, parent: ASTNode?)
    func exit(_ node: ASTNode, parent: ASTNode?)
}

// MARK: - Traverser

func traverser(ast: Program, visitor: Visitor) {
    
    func traverseArray(_ array: [ASTNode], parent: ASTNode) {
        for child in array {
            traverseNode(child, parent: parent)
        }
    }
    
    func traverseNode(_ node: ASTNode, parent: ASTNode?) {
        // Call enter method if it exists
        visitor.enter(node, parent: parent)
        
        // Traverse children based on node type
        switch node.type {
        case .program:
            if let program = node as? Program {
                traverseArray(program.body, parent: node)
            }
            
        case .callExpression:
            if let callExpression = node as? CallExpression {
                traverseArray(callExpression.params, parent: node)
            }
            
        case .numberLiteral, .stringLiteral:
            // Leaf nodes - no children to traverse
            break
            
        case .identifier, .expressionStatement:
            // These node types don't have children in our current AST
            break
        }
        
        // Call exit method if it exists
        visitor.exit(node, parent: parent)
    }
    
    // Start traversal from the root node
    traverseNode(ast, parent: nil)
}

// MARK: - Example Visitor Implementation

class PrintVisitor: Visitor {
    func enter(_ node: ASTNode, parent: ASTNode?) {
        let parentInfo = parent?.type.rawValue ?? "none"
        print("Entering \(node.type.rawValue) (parent: \(parentInfo))")
        
        // Print additional info based on node type
        switch node.type {
        case .callExpression:
            if let callExpr = node as? CallExpression {
                print("  Function name: \(callExpr.name)")
            }
        case .numberLiteral:
            if let numLit = node as? NumberLiteral {
                print("  Value: \(numLit.value)")
            }
        case .stringLiteral:
            if let strLit = node as? StringLiteral {
                print("  Value: \(strLit.value)")
            }
        default:
            break
        }
    }
    
    func exit(_ node: ASTNode, parent: ASTNode?) {
        let parentInfo = parent?.type.rawValue ?? "none"
        print("Exiting \(node.type.rawValue) (parent: \(parentInfo))")
    }
}

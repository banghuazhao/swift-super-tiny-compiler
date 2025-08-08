//
// Created by Banghua Zhao on 08/08/2025
// Copyright Apps Bay Limited. All rights reserved.
//

import Foundation

func compiler(input: String) -> String {
    let tokens = tokenizer(input: input)
    let ast = parser(tokens: tokens)
    let visitor = TransformerVisitor()
    traverser(ast: ast, visitor: visitor)
    let transformedAST = visitor.getTransformedAST()
    let output = codeGenerator(node: transformedAST)
    return output
}

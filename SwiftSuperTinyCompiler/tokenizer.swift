import Foundation

// MARK: - Token Types

enum TokenType: String {
    case paren = "paren"
    case number = "number"
    case string = "string"
    case name = "name"
}

struct Token {
    let type: TokenType
    let value: String
}

// MARK: - Tokenizer

func tokenizer(input: String) -> [Token] {
    var current = 0
    var tokens: [Token] = []
    
    while current < input.count {
        let char = String(input[input.index(input.startIndex, offsetBy: current)])
        
        // Check for open parenthesis
        if char == "(" {
            tokens.append(Token(type: .paren, value: "("))
            current += 1
            continue
        }
        
        // Check for closing parenthesis
        if char == ")" {
            tokens.append(Token(type: .paren, value: ")"))
            current += 1
            continue
        }
        
        // Check for whitespace (ignore)
        let whitespace = CharacterSet.whitespaces
        if char.unicodeScalars.allSatisfy({ whitespace.contains($0) }) {
            current += 1
            continue
        }
        
        // Check for numbers
        let numbers = CharacterSet.decimalDigits
        if char.unicodeScalars.allSatisfy({ numbers.contains($0) }) {
            var value = ""
            
            // Consume all consecutive digits
            while current < input.count {
                let currentChar = String(input[input.index(input.startIndex, offsetBy: current)])
                if currentChar.unicodeScalars.allSatisfy({ numbers.contains($0) }) {
                    value += currentChar
                    current += 1
                } else {
                    break
                }
            }
            
            tokens.append(Token(type: .number, value: value))
            continue
        }
        
        // Check for strings (quoted text)
        if char == "\"" {
            var value = ""
            current += 1 // Skip opening quote
            
            // Consume until closing quote
            while current < input.count {
                let currentChar = String(input[input.index(input.startIndex, offsetBy: current)])
                if currentChar == "\"" {
                    current += 1 // Skip closing quote
                    break
                }
                value += currentChar
                current += 1
            }
            
            tokens.append(Token(type: .string, value: value))
            continue
        }
        
        // Check for names (letters)
        let letters = CharacterSet.letters
        if char.unicodeScalars.allSatisfy({ letters.contains($0) }) {
            var value = ""
            
            // Consume all consecutive letters
            while current < input.count {
                let currentChar = String(input[input.index(input.startIndex, offsetBy: current)])
                if currentChar.unicodeScalars.allSatisfy({ letters.contains($0) }) {
                    value += currentChar
                    current += 1
                } else {
                    break
                }
            }
            
            tokens.append(Token(type: .name, value: value))
            continue
        }
        
        // Unknown character
        fatalError("I don't know what this character is: \(char)")
    }
    
    return tokens
}

import Foundation
// Rail-Fence Cipher - Jumble plain text in a zig-zag fashion
// using two dimensional arrays

// How the Cipher works

// Encoding
//In a transposition cipher, the order of the alphabets is re-arranged to obtain the cipher-text.
//
//In the rail fence cipher, the plain-text is written downwards and diagonally on successive rails of an imaginary fence.
//When we reach the bottom rail, we traverse upwards moving diagonally, after reaching the top rail, the direction is changed again. Thus the alphabets of the message are written in a zig-zag manner.
//After each alphabet has been written, the individual rows are are combined to obtain the cipher-text.


// Decoding
// Hence, rail matrix can be constructed accordingly. Once we’ve got the matrix we can figure-out the spots where texts should be placed (using the same way of moving diagonally up and down alternatively ).
//Then, we fill the cipher-text row wise. After filling it, we traverse the matrix in zig-zag manner to obtain the original text.


struct RailfenceCipherAlgo: Cipher {
    func validInputCheck( text: String, secret: String ) -> String {
        // Cipher text should not be empty
        if( text.isEmpty ) { return "Please enter Cipher text to encode" }
        
        // Secret is needed for Rail Fence, should be a number, and greater than 1
        if( secret.isEmpty )            { return "Please make sure Cipher key is entered" }
        else if( Int( secret ) == nil ) { return "Please make sure Cipher key entered is valid" }
        else if( Int( secret )! <= 1 )  { return "Please make sure Cipher key is entered Greater Than 1" }
        
        return "" // No Errors
    }
    
    // Flips -1 or +1 based on the condition
    func conditionalDirection( _ direction: Int, _ row: Int, _ MAX_UPPER_BOUND: Int ) -> Int {
        if( row == MAX_UPPER_BOUND || row == 0 ) { return ( direction * -1 ) }
        
        return direction
    }
    
    func encodeText( _ plaintext: String, secret: String ) -> String {
        // Check for Invalid Input
        let errorMessage = validInputCheck( text: plaintext, secret: secret )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        // Remove the spaces from Cipher Text if any
        var trimmedCipherText = plaintext.replacingOccurrences( of: " ", with: "" )
        
        var encryptedSubstringsArray = Array( repeating: "", count: Int( secret )! )
        let MAX_UPPER_BOUND = Int( secret )! - 1
        var currentRow = 0, direction = -1
        
        // Iterate all the characters and add characters to substrings in zig-zag pattern
        while !trimmedCipherText.isEmpty {
            let firstCharacter = trimmedCipherText.prefix( 1 )
            
            encryptedSubstringsArray[ currentRow ] += firstCharacter

            trimmedCipherText.remove( at: trimmedCipherText.startIndex )
            
            // should be allow to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        var encryptedText = ""
        
        for substring in encryptedSubstringsArray { encryptedText += substring }
        
        return encryptedText
    }
    
    func decodeEncryptedText( _ encryptedText: String, secret: String ) -> String {
        // Check input should not be invalid
        let errorMessage = validInputCheck( text: encryptedText, secret: secret )
        
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        // Initialising Variables for decoding algorithm
        let MAX_COLUMNS = encryptedText.count, MAX_UPPER_BOUND = Int( secret )! - 1
        var currentRow = 0, direction = -1, textToDecode = encryptedText
        
        // Initialising secret x MAX_COLUMNS 2D array of X's
        var decodeMatrix = Array( repeating: Array(repeating: "❌", count: MAX_COLUMNS ), count: Int( secret )! )
        
        // Iterate the decode matrix and place ✅'s on valid places to save characters from the encrypted string
        for index in 0..<MAX_COLUMNS {
            decodeMatrix[ currentRow ][ index ] = "✅"

            // should be allow to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        // Insert the encrypedText's characters at valid postions
        for row in 0...MAX_UPPER_BOUND {
            for column in 0..<MAX_COLUMNS {
                if( decodeMatrix[ row ][ column ] == "✅" ) {
                    let firstCharacter = textToDecode.prefix( 1 )
                    
                    decodeMatrix[ row ][ column ].removeAll()
                    decodeMatrix[ row ][ column ] = String( firstCharacter )
                    
                    textToDecode.remove( at: textToDecode.startIndex )
                }
            }
        }
        
        // variable for decrypted text string
        var decryptedText = ""
        currentRow = 0; direction = -1 // Reset currentRow and Direction
        
        for index in 0..<MAX_COLUMNS {
            decryptedText += decodeMatrix[ currentRow ][ index ]
            
            // should Allow to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        return decryptedText
    }
}

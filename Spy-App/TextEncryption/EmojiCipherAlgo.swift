import Foundation
// Emoji Cipher - Match a Plaintext Character to an iOS supported Emoji
// How the Cipher works

// Encryption Steps
// 1. Input will be a plain text string
// 2. Convert every character to its equivalent hexadecimal value, based on that
//    hex value, add a constant integer value to the character's unicode value.
//    This will shift the character from ASCII plan text to a supported emoji.
// 3. Return the Emoji and append to an encrypted message string

// Decryption Steps
// 1. Take an emoji string which needs to decode
// 2. Iterate each character and compare its Unicode against the constant integer
//    values that were used to shift the values.
// 3. If the Unicode value is greater than the constant value ( compare the greatest constant
//    values to lowest ), subtract that constant value to get your original character.
// 4. Append converted character to decrypted text string, return that string

struct EmojiCipherAlgo: Cipher {
    
    // Secret key is not needed for Emoji Cipher
    func validInputCheck( text: String, secret: String ) -> String {
        // text should be non-empty
        if( text.isEmpty ) { return "Please enter Cipher text to encode" }
        
        return "" // All good
    }
    
    // Add U+1F200 unicode to current code
    func addFTwoHundred( _ code: UInt32 ) -> Bool {
        return ( code == 0x50 || code == 0x51 )
    }
    
    // Add U+1F300 to current code
    func addFThreeHundred( _ code: UInt32 ) -> Bool {
        return (
           ( code >= 0x41 && code <= 0x4A ) ||
           ( code >= 0x54 && code <= 0x7B )
        )
    }
    
    // Add U+1F400 unicode to current code
    func addFFourHundred( _ code: UInt32 ) -> Bool {
        return (
            ( code >= 0x26 && code <= 0x29 ) ||
            ( code >= 0x2D && code <= 0x39 ) ||
            ( code >= 0x4B && code <= 0x4F ) ||
            ( code >= 0x7C && code <= 0x7E )
        )
    }
    
    // Add U+1F500 unicode to current code
    func addFFiveHundred( _ code: UInt32 ) -> Bool {
        return ( code >= 0x2A && code <= 0x2C )
    }
    
    // Add U+1F600 unicode to current code
    func addFSixHundred( _ code: UInt32 ) -> Bool {
        return (
            ( code >= 0x21 && code <= 0x25 ) ||
            ( code >= 0x3A && code <= 0x3F ) ||
            ( code == 0x40 )
        )
    }
    
    // Add U+2600 unicode to current code
    func addTwoSixHundred( _ code: UInt32 ) -> Bool {
        return ( code == 0x52 || code == 0x53 )
    }
    
    func encodeText( _ plaintext: String, secret: String ) -> String {
        // Check if the input is valid or not
        let errorMessage = validInputCheck( text: plaintext, secret: secret )
        //if error return error message
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var encodedMessage = ""
        //iterate each character
        for character in plaintext {
            var plainTextUnicode = character.unicodeScalars.first!.value
            
            // Checking the current Unicode value and depending on that add various hex value constants.
            if ( addFTwoHundred( plainTextUnicode )) {
                plainTextUnicode += 0x1F200
                
            } else if ( addFThreeHundred( plainTextUnicode )) {
                plainTextUnicode += 0x1F300
                
            } else if ( addFFourHundred( plainTextUnicode )) {
                plainTextUnicode += 0x1F400
                
            } else if ( addFFiveHundred( plainTextUnicode )) {
                plainTextUnicode += 0x1F500
                
            } else if ( addFSixHundred( plainTextUnicode )) {
                plainTextUnicode += 0x1F600
                
            } else if ( addTwoSixHundred( plainTextUnicode )) {
                plainTextUnicode += 0x2600
                
            }
            
            // Convert new unicode Int value to string
            let emojiUnicode = String( UnicodeScalar( UInt32( plainTextUnicode ) )! )
            
            encodedMessage += emojiUnicode
        }
        
        return encodedMessage
    }
    
    func decodeEncryptedText( _ encryptedText: String, secret: String ) -> String {
        // text should be non-empty
        let errorMessage = validInputCheck( text: encryptedText, secret: secret )
        //if error return
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var decodedMessage = ""
        
        for character in encryptedText {
            var emojiUnicode = character.unicodeScalars.first!.value
            
            // Check the range of the Unicode value and subtract the constant hex values whicj added during encoding
            if ( emojiUnicode >= 0x1F600 ) {
                emojiUnicode -= 0x1F600
                
            } else if ( emojiUnicode >= 0x1F500 ) {
                emojiUnicode -= 0x1F500
                
            } else if ( emojiUnicode >= 0x1F400 ) {
                emojiUnicode -= 0x1F400
                
            } else if ( emojiUnicode >= 0x1F300 ) {
                emojiUnicode -= 0x1F300
                
            } else if ( emojiUnicode >= 0x1F200 ) {
                emojiUnicode -= 0x1F200
                
            } else if ( emojiUnicode >= 0x2600 ) {
                emojiUnicode -= 0x2600
                
            }
            
            // to decode Plain text Character - Convert the Unicode Int value to String
            let plainTextUnicode = String( UnicodeScalar( UInt32( emojiUnicode ) )! )

            decodedMessage += plainTextUnicode
        }
        
        return decodedMessage
    }
}

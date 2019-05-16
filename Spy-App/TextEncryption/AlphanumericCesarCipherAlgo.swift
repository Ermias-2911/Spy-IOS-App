// Task number 2
import Foundation

struct AlphanumericCesarCipherAlgo: Cipher {
    
    func validInputCheck(text: String, secret: String) -> String {
        // Cipher Text Exists
        if( text.isEmpty )                 { return "Please enter Cipher text to encode" }
        else if( !isAlphanumeric( text ) ) { return "Please enter Alphanumeric Cipher text only" }
        
        // Secret must be present, and a valid number
        if( secret.isEmpty )            { return "Please make sure Cipher key is entered" }
        else if( Int( secret ) == nil  || Int( secret )! < 0 ) { return "Please make sure Cipher key entered is valid" }

        return "" // No Errors
    }
    
    func isAlphanumeric( _ text: String ) -> Bool {
        return !text.isEmpty && text.range( of: "[^a-zA-Z0-9]", options: .regularExpression ) == nil
    }
    
    func returnCodeInBounds( _ code:UInt32 ) -> UInt32 {
        let upperCaseAUnicode = String( "A" ).unicodeScalars.first!.value
        let upperCaseZUnicode = String( "Z" ).unicodeScalars.first!.value
        let numberZeroUnicode = String( "0" ).unicodeScalars.first!.value
        let numberNineUnicode = String( "9" ).unicodeScalars.first!.value
        
        if ( code > upperCaseZUnicode ) {
            return numberZeroUnicode
            
        } else if ( code == upperCaseAUnicode - 1 ) {
            return numberNineUnicode
            
        } else if ( code < numberZeroUnicode ) {
            return upperCaseZUnicode
            
        } else if ( code == numberNineUnicode + 1 ) {
            return upperCaseAUnicode
            
        }
        
        return code
    }
    
    func encodeText( _ plaintext: String, secret: String ) -> String {
        // Check for Invalid Input
        let errorMessage = validInputCheck( text: plaintext, secret: secret )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var encodedText = ""
        let shiftBy = UInt32( secret )!
        let lowerCaseText = plaintext.uppercased()
        
        for character in lowerCaseText {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode + shiftBy
            shiftedUnicode = returnCodeInBounds( shiftedUnicode )
            
            // update: UInt8 -> UInt16
            let shiftedCharacter = String( UnicodeScalar( UInt16( shiftedUnicode ) )! )
            
            encodedText += shiftedCharacter
        }
        return encodedText
    }
    
    func decodeEncryptedText( _ encryptedText: String, secret: String ) -> String {
        // Check for Invalid Input
        let errorMessage = validInputCheck( text: encryptedText, secret: secret )
        if( !errorMessage.isEmpty ) { return errorMessage }

        var decodedMessage = ""
        let shiftBy = UInt32( secret )!
        
        for character in encryptedText {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode - shiftBy
            shiftedUnicode = returnCodeInBounds( shiftedUnicode )
            
            // error: Thread 1: Fatal error: Not enough bits to represent a signed value
            // fix: UInt8 -> UInt16
            let shiftedCharacter = String( UnicodeScalar( UInt16( shiftedUnicode ) )! )
            
            decodedMessage += shiftedCharacter
        }
        return decodedMessage
    }
}

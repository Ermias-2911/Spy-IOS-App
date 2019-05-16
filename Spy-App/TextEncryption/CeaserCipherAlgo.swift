import Foundation

protocol Cipher {
    func encodeText(_ plaintext: String, secret: String) -> String

    func decodeEncryptedText(_ encryptedText: String, secret: String) -> String
    
    func validInputCheck( text: String, secret: String ) -> String
}

struct CeaserCipherAlgo: Cipher {

    func validInputCheck(text: String, secret: String) -> String {
        // Cipher Text Exists
        if( text.isEmpty ) { return "Please enter Cipher text to encode" }
        
        // Secret must be present, and a valid number
        if( secret.isEmpty )            { return "Please make sure Cipher key is entered" }
        else if( Int( secret ) == nil  || Int( secret )! < 0) { return "Please make sure Cipher key entered is valid" }
        
        return "" // All good
    }
    
    func encodeText(_ plaintext: String, secret: String) -> String {
        // Check iput should be valid
        let errorMessage = validInputCheck( text: plaintext, secret: secret )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var encoded = ""
        let shiftBy = UInt32(secret)!

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            // update: UInt8 -> UInt16
            let shiftedCharacter = String(UnicodeScalar(UInt16(shiftedUnicode))!)
            encoded += shiftedCharacter
        }
        return encoded
    }
    
    func decodeEncryptedText(_ encryptedText: String, secret: String) -> String {
        // Check iput should be valid
        let errorMessage = validInputCheck( text: encryptedText, secret: secret )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var decoded = ""
        let shiftBy = UInt32(secret)!
        
        for character in encryptedText {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt16(shiftedUnicode))!)
            
            decoded += shiftedCharacter
        }
        return decoded
    }
}

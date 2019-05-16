import Foundation

// Cipher Factory which will return the Class instance depending on  the encode and decode
struct CipherFactoryHelper {

    private var ciphers: [ String: Cipher ] = [
        "Cesar Cipher": CeaserCipherAlgo(),
        "Alphanumeric Cesar Cipher": AlphanumericCesarCipherAlgo(),
        "Emoji Cipher": EmojiCipherAlgo(),
        "Rail-Fence Cipher": RailfenceCipherAlgo(),
    ]

    func cipher( for key: String ) -> Cipher {
        return ciphers[ key ]!
    }
}

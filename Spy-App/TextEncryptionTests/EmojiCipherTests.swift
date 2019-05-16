import XCTest
@testable import SpyApp

class EmojiCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = EmojiCipher()
    }
    
    // Invalid Validation Unit Tests
    func test_emptyCipherText() {
        let encodeResult = cipher.encode("", secret: "")
        let decodeResult = cipher.decode("", secret: "")
        XCTAssertEqual("Please enter Cipher text to encode", encodeResult)
        XCTAssertEqual("Please enter Cipher text to encode", decodeResult)
    }

    func test_encodingAlgorithmWithMultipleCipherTexts() {
        let result0 = cipher.encode("Hello World", secret: "")
        XCTAssertEqual("🍈🍥🍬🍬🍯 🍗🍯🍲🍬🍤", result0)
        
        let result1 = cipher.encode("Unit Testing String", secret: "")
        XCTAssertEqual("🍕🍮🍩🍴 🍔🍥🍳🍴🍩🍮🍧 ♓🍴🍲🍩🍮🍧", result1)
        
        let result2 = cipher.encode("I just love love, you know?", secret: "")
        XCTAssertEqual("🍉 🍪🍵🍳🍴 🍬🍯🍶🍥 🍬🍯🍶🍥🔬 🍹🍯🍵 🍫🍮🍯🍷😿", result2)
        
        let result3 = cipher.encode("Cool Beans Brochacho", secret: "")
        XCTAssertEqual("🍃🍯🍯🍬 🍂🍥🍡🍮🍳 🍂🍲🍯🍣🍨🍡🍣🍨🍯", result3)
    }
    
    func test_entireKeyboard() {
        let encodeResult = cipher.encode("`1234567890-=~!@#$%^&*()_+qwertyuiop[]QWERTYUIOP{}|asdfghjkl;'ASDFGHJKL:zxcvbnm,./ZXCVBNM<>?", secret: "")
        XCTAssertEqual("🍠🐱🐲🐳🐴🐵🐶🐷🐸🐹🐰🐭😽👾😡🙀😣😤😥🍞🐦🔪🐨🐩🍟🔫🍱🍷🍥🍲🍴🍹🍵🍩🍯🍰🍛🍝🉑🍗🍅♒🍔🍙🍕🍉👏🉐🍻👽👼🍡🍳🍤🍦🍧🍨🍪🍫🍬😻🐧🍁♓🍄🍆🍇🍈🍊👋👌😺🍺🍸🍣🍶🍢🍮🍭🔬🐮🐯🍚🍘🍃🍖🍂👎👍😼😾😿", encodeResult)
        
        let decodeResult = cipher.decode("🍠🐱🐲🐳🐴🐵🐶🐷🐸🐹🐰🐭😽👾😡🙀😣😤😥🍞🐦🔪🐨🐩🍟🔫🍱🍷🍥🍲🍴🍹🍵🍩🍯🍰🍛🍝🉑🍗🍅♒🍔🍙🍕🍉👏🉐🍻👽👼🍡🍳🍤🍦🍧🍨🍪🍫🍬😻🐧🍁♓🍄🍆🍇🍈🍊👋👌😺🍺🍸🍣🍶🍢🍮🍭🔬🐮🐯🍚🍘🍃🍖🍂👎👍😼😾😿", secret: "")
        XCTAssertEqual("`1234567890-=~!@#$%^&*()_+qwertyuiop[]QWERTYUIOP{}|asdfghjkl;'ASDFGHJKL:zxcvbnm,./ZXCVBNM<>?", decodeResult)
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {
        let result0 = cipher.decode("♓🍯🍭🍥🍢🍯🍤🍹 🍯🍮🍣🍥 🍴🍯🍬🍤 🍭🍥", secret: "")
        XCTAssertEqual("Somebody once told me", result0)
        
        let result1 = cipher.decode("🍴🍨🍥 🍷🍯🍲🍬🍤 🍩🍳 🍧🍯🍮🍮🍡 🍲🍯🍬🍬 🍭🍥", secret: "")
        XCTAssertEqual("the world is gonna roll me", result1)
        
        let result2 = cipher.decode("🍉 🍡🍩🍮🐧🍴 🍴🍨🍥 🍳🍨🍡🍲🍰🍥🍳🍴 🍴🍯🍯🍬 🍩🍮 🍴🍨🍥 🍳🍨🍥🍤", secret: "")
        XCTAssertEqual("I ain't the sharpest tool in the shed", result2)
        
    }
}


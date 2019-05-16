import XCTest
@testable import SpyApp

class CeasarCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = CeaserCipher()
    }
    
    // Invalid Validation Unit Tests
    func test_emptyCipherText() {
        let encodeResult = cipher.encode("", secret: "0")
        let decodeResult = cipher.decode("", secret: "0")
        XCTAssertEqual("Please enter Cipher text to encode", encodeResult)
        XCTAssertEqual("Please enter Cipher text to encode", decodeResult)
    }
    
    func test_emptySecretText() {
        let encodeResult = cipher.encode("Test Cipher Text", secret: "")
        let decodeResult = cipher.decode("Test Cipher Text", secret: "")
        XCTAssertEqual("Please make sure Cipher key is entered", encodeResult)
        XCTAssertEqual("Please make sure Cipher key is entered", decodeResult)
    }
    
    func test_nonNumericInputForSecretText() {
        let encodeResult = cipher.encode("Test Cipher Text", secret: "A")
        let decodeResult = cipher.decode("Test Cipher Text", secret: "A")
        XCTAssertEqual("Please make sure Cipher key entered is valid", encodeResult)
        XCTAssertEqual("Please make sure Cipher key entered is valid", decodeResult)
    }
    
    func test_negativeSecretText() {
        let encodeResult = cipher.encode("Test Cipher Text", secret: "-1")
        let decodeResult = cipher.decode("Test Cipher Text", secret: "-1")
        XCTAssertEqual("Please make sure Cipher key entered is valid", encodeResult)
        XCTAssertEqual("Please make sure Cipher key entered is valid", decodeResult)
    }
    
    // Encoding Unit Tests
    func test_oneCharacterStringGetsMappedToSelfWith_0_secret() {
        let plaintext = "a"
        let result = cipher.encode(plaintext, secret: "0")
        XCTAssertEqual(plaintext, result)
    }
    
    func test_encodingAlgorithmWithMultipleSecrets() {
        let result0 = cipher.encode("Hello World", secret: "0")
        XCTAssertEqual("Hello World", result0)
        
        let result1 = cipher.encode("Hello World", secret: "1")
        XCTAssertEqual("Ifmmp!Xpsme", result1)
        
        let result2 = cipher.encode("Hello World", secret: "2")
        XCTAssertEqual("Jgnnq\"Yqtnf", result2)
        
        let result3 = cipher.encode("Hello World", secret: "3")
        XCTAssertEqual("Khoor#Zruog", result3)
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {
        let result0 = cipher.decode("Hello World", secret: "0")
        XCTAssertEqual("Hello World", result0)
        
        let result1 = cipher.decode("Ifmmp!Xpsme", secret: "1")
        XCTAssertEqual("Hello World", result1)
        
        let result2 = cipher.decode("Jgnnq\"Yqtnf", secret: "2")
        XCTAssertEqual("Hello World", result2)
        
        let result3 = cipher.decode("Khoor#Zruog", secret: "3")
        XCTAssertEqual("Hello World", result3)
    }
}

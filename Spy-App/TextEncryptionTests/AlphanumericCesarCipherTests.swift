import XCTest
@testable import SpyApp

class AlphanumericCeasarCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphanumericCesarCipher()
    }
    
    // Invalid Validation Unit Tests
    func test_emptyCipherText() {
        let encodeResult = cipher.encode("", secret: "0")
        let decodeResult = cipher.decode("", secret: "0")
        XCTAssertEqual("Please enter Cipher text to encode", encodeResult)
        XCTAssertEqual("Please enter Cipher text to encode", decodeResult)
    }
    
    func test_NonAlphanumericCipherText() {
        let encodeResult = cipher.encode("~!@#$%^&*()_-+={}[]|;:'", secret: "0")
        let decodeResult = cipher.decode("~!@#$%^&*()_-+={}[]|;:'", secret: "0")
        XCTAssertEqual("Please enter Alphanumeric Cipher text only", encodeResult)
        XCTAssertEqual("Please enter Alphanumeric Cipher text only", decodeResult)
    }
    
    func test_emptySecretText() {
        let encodeResult = cipher.encode("Test", secret: "")
        let decodeResult = cipher.decode("Test", secret: "")
        XCTAssertEqual("Please make sure Cipher key is entered", encodeResult)
        XCTAssertEqual("Please make sure Cipher key is entered", decodeResult)
    }
    
    func test_nonNumericInputForSecretText() {
        let encodeResult = cipher.encode("Test", secret: "A")
        let decodeResult = cipher.decode("Test", secret: "A")
        XCTAssertEqual("Please make sure Cipher key entered is valid", encodeResult)
        XCTAssertEqual("Please make sure Cipher key entered is valid", decodeResult)
    }
    
    // Encoding Unit Tests
    func test_cipherTextConvertedToUpperCase() {
        let plaintext = "abcdefghijklmnopqrstuvwxyz"
        let result = cipher.encode(plaintext, secret: "0")
        XCTAssertEqual(plaintext.uppercased(), result)
    }
    
    func test_cipherTextDigitsAreValid() {
        let result = cipher.encode("0123456789", secret: "0")
        XCTAssertEqual("0123456789", result)
    }
    
    func test_encodingAlgorithmWithMultipleSecrets() {
        let result0 = cipher.encode("HelloWorld", secret: "0")
        XCTAssertEqual("HELLOWORLD", result0)
        
        let result1 = cipher.encode("HelloWorld", secret: "1")
        XCTAssertEqual("IFMMPXPSME", result1)

        let result2 = cipher.encode("HelloWorld", secret: "2")
        XCTAssertEqual("JGNNQYQTNF", result2)

        let result3 = cipher.encode("HelloWorld", secret: "3")
        XCTAssertEqual("KHOORZRUOG", result3)
    }
    
    func test_characterSkipping() {
        let resultA = cipher.encode("9", secret: "1")
        XCTAssertEqual(resultA, "A")
        
        let resultZ = cipher.decode("0", secret: "1")
        XCTAssertEqual(resultZ, "Z")
        
        let result0 = cipher.encode("Z", secret: "1")
        XCTAssertEqual(result0, "0")
        
        let result9 = cipher.decode("A", secret: "1")
        XCTAssertEqual(result9, "9")
        
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {
        let result0 = cipher.decode("HELLOWORLD", secret: "0")
        XCTAssertEqual("HELLOWORLD", result0)
        
        let result1 = cipher.decode("IFMMPXPSME", secret: "1")
        XCTAssertEqual("HELLOWORLD", result1)

        let result2 = cipher.decode("JGNNQYQTNF", secret: "2")
        XCTAssertEqual("HELLOWORLD", result2)

        let result3 = cipher.decode("KHOORZRUOG", secret: "3")
        XCTAssertEqual("HELLOWORLD", result3)
    }
}


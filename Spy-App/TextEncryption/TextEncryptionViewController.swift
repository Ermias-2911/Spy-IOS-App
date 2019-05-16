import UIKit

class TextEncryptionViewController: UIViewController {
//view components for verifying the alogorithms
    @IBOutlet weak var inputTextView: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var secret: UITextField!
    
    @IBOutlet weak var cesarCipherButton: UIButton!
    @IBOutlet weak var alphanumericCipherButton: UIButton!
    @IBOutlet weak var emojiCipherButton: UIButton!
    @IBOutlet weak var railfenceCipherButton: UIButton!
    
    @IBOutlet weak var encodeButton: UIButton!
    @IBOutlet weak var decodeButton: UIButton!
    
    let factoryHelper = CipherFactoryHelper()
    var cipher: Cipher!
    
    var getPlaintext: String {
        if let text = inputTextView.text {
            return text
        } else {
            return ""
        }
    }
    
    var getEncryptedText: String {
        if let text = inputTextView.text {
            return text
        } else {
            return ""
        }
    }
    
    var getSecretText: String {
        if let text = secret.text {
            return text
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button Styling done at run time - Rounded Corners
        cesarCipherButton.layer.cornerRadius = 5
        alphanumericCipherButton.layer.cornerRadius = 5
        emojiCipherButton.layer.cornerRadius = 5
        railfenceCipherButton.layer.cornerRadius = 5
        
        encodeButton.layer.cornerRadius = 5
        decodeButton.layer.cornerRadius = 5
        outputTextView.layer.cornerRadius = 5
        alphanumericCipherButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        if let cipher = self.cipher {
            outputTextView.text = cipher.encodeText(getPlaintext, secret: getSecretText)
        } else {
            outputTextView.text = "Please select a Cipher."
        }
    }

    @IBAction func decodeButtonPressed(_ sender: UIButton) {
        if let cipher = self.cipher {
            outputTextView.text = cipher.decodeEncryptedText(getEncryptedText, secret: getSecretText)
        } else {
            outputTextView.text = "Please select a Cipher."
        }
    }
    
    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        guard
          let buttonLabel = sender.titleLabel,
          let buttonText = buttonLabel.text
        else {
            outputTextView.text = "No button or no button text."
            return
        }
        cipher = factoryHelper.cipher(for: buttonText)
    }
}

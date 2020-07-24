import UIKit
import Firebase


class ServiceDetailViewController: UIViewController {

    var serviceID : String = ""
    
    @IBOutlet weak var serviceText: UILabel!

    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UITextView!
    @IBOutlet weak var text4: UITextView!
    @IBOutlet weak var text5: UITextView!
    @IBOutlet weak var text6: UITextView!
    @IBOutlet weak var text7: UITextView!
    
    
    let db =
        Firestore.firestore()
    let collectionName = "corona"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUITextViewHeight(arg: text1)
        adjustUITextViewHeight(arg: text2)
        adjustUITextViewHeight(arg: text3)
        adjustUITextViewHeight(arg: text4)
        adjustUITextViewHeight(arg: text5)
        adjustUITextViewHeight(arg: text6)
        adjustUITextViewHeight(arg: text7)
        
        loadService()
        // Do any additional setup after loading the view.
    }
    
    func loadService(){
        let docRef = db.collection(collectionName).document(serviceID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.serviceText.text = document["서비스명"] as! String
                self.text1.text = document["문의처 명"] as! String
                self.text2.text = document["지원대상"] as! String
                self.text3.text = document["지원내용"] as! String
                self.text4.text = document["신청기한"] as! String
                self.text5.text = document["구비서류"] as! String
                self.text6.text = document["문의처 전화번호"] as! String
                self.text7.text = document["서비스 상세 주소"] as! String

                
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        //arg.sizeToFit()
        arg.isScrollEnabled = true
    }


}



import UIKit
import Firebase

class ServiceResultViewController: UIViewController {

    //    var messages : [Message] = []
    var pick1 : String = "강원도"
    var pick2 : String = "강원도"
    var keyword : String = ""
    var timeIsTrue : Bool = true
    
    var services : [Service] = []

    
    
    let db = Firestore.firestore()
    
    let collectionName = "corona"
    let pick1Field = "지역 단위"
    let pick2Field = "소관기관 명"
    let tableField = "서비스명"
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadServices()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    func loadServices(){
        //먼저 hardcoding후 연결되는지 확인
        db.collection(collectionName).whereField(pick1Field, isEqualTo: pick1).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let tempId = document.documentID
                    let tempService = Service(serviceName: data[self.tableField] as! String, id: tempId)
                    self.services.append(tempService)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                
                    print("\(tempId) => \(data[self.tableField])")
//                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }


}

extension ServiceResultViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = services[indexPath.row].serviceName
        
        return cell
    }
}


extension ServiceResultViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

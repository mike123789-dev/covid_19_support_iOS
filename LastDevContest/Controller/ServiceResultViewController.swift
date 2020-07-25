import UIKit
import Firebase

class ServiceResultViewController: UIViewController {

    //    var messages : [Message] = []
    var pick1 : String = "강원도"
    var pick2 : String = "강원도"
    var keyword : String = ""
    var timeIsTrue : Bool = true
    
    var services : [Service] = []
    var serviceID : String = ""
    
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
        print("$$$$$$$$$$$$^^^^^^^^^^^^^$$$$$$$$$$$$$")
        print("pick1 :  \(pick1)")
        print("pick2 :  \(pick2)")
        print("keyword :  \(keyword)")
        print("timeistrue :  \(timeIsTrue)")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    func loadServices(){
        //먼저 hardcoding후 연결되는지 확인
        if pick1 == "전체" {
            db.collection(collectionName).getDocuments(){
                (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        self.serviceID = document.documentID
                        let tempService = Service(serviceName: data["서비스명"] as! String, id: data["ID"] as! String, filterPick1: data["지역 단위"] as! String, filterPick2: data["소관기관 명"] as! String, filter1: data["서비스명"] as! String, filter2: data["서비스명"] as! String)
                        
                        
                        self.services.append(tempService)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        else{
            db.collection(collectionName).whereField(pick1Field, isEqualTo: pick1).getDocuments(){
                (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        self.serviceID = document.documentID
                        let tempService = Service(serviceName: data["서비스명"] as! String, id: data["ID"] as! String, filterPick1: data["지역 단위"] as! String, filterPick2: data["소관기관 명"] as! String, filter1: data["서비스명"] as! String, filter2: data["서비스명"] as! String)
                        print(tempService)
                        
                        if self.pick2 == "전체"{
                            print("pick2 is 전체")

                            //전체 일때는 모두다
                            if self.keyword == ""{
                                //키워드가 비워져있을떄는 모두다
                                self.services.append(tempService)
                            }
                            else if tempService.filter1.contains(self.keyword) || tempService.filter2.contains(self.keyword){
                                print("found keyword")
                                self.services.append(tempService)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        else{
                            print("pick is not 전체")

                            if self.pick2 == tempService.filterPick2{
                                print("pick2 is \(self.pick2)")
                                if self.keyword == ""{
                                    //키워드가 비워져있을떄는 모두다
                                    self.services.append(tempService)
                                }
                                else if tempService.filter1.contains(self.keyword) || tempService.filter2.contains(self.keyword){
                                    print("found keyword")
                                    self.services.append(tempService)
                                }
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                        
                    }
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail"){
            let serviceDetailVC = segue.destination as! ServiceDetailViewController
            print("prepare segue")
            print(serviceID)
            serviceDetailVC.serviceID = serviceID
        }
    }
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "searchKeyword"){
//            let serviceResultVC = segue.destination as! ServiceResultViewController

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
        print("didSelectRowAt")
        serviceID = services[indexPath.row].id
        print(serviceID)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}

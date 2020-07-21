import UIKit

class ServiceResultViewController: UIViewController {

    //    var messages : [Message] = []

    
    var services : [Service] = []

    let service1 = Service(serviceName: "워라밸일자리 장려금 지원 사업", howTo: "신청방법: 방문, 우편, 웹사이트(www.ei.go.kr) 등", needDocument: "신분증" , siteUrl: "www.ei.go.kr")
    let service2 = Service(serviceName: "코로나 19 건설일용근로자 긴급생활안정자금 융자", howTo: "신청방법 : 건설근로자공제회 지사·센터를 통한 현장 신청", needDocument: "신분증" , siteUrl: "www.naver.com")
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        services.append(service1)
        services.append(service2)
        tableView.dataSource = self
        tableView.delegate = self
        
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

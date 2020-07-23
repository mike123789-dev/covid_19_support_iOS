//
//  HomeViewController.swift
//  LastDevContest
//
//  Created by 강병민 on 2020/07/22.
//  Copyright © 2020 강병민. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let pickData =
    [
        "강원도" : ["강원도" , "삼척시", "양구군", "양양군", "철원군", "홍천군"],
        "경기도" : ["경기도" , "고양시", "과천시", "광주시", "구리시", "김포시","동두천시" , "부천시", "수원시", "시흥시", "안성시","안양시" , "양주시", "양평군", "여주시", "오산시", "용인시" , "의왕시", "의정부시", "이천시", "평택시", "포천시" , "하남시"],
        "경상남도" : ["경상남도" , "거제시", "밀양시", "산청군", "진주시", "창원시","통영시","경상남도교육청"],
        "경상북도" : ["경상북도" , "경산시", "경주시", "구미시", "김천시", "봉화군","안동시","영천시","예천군","청도군","칠곡군"],
        
        
        "서울특별시" : ["서울특별시" , "관악구", "노원구", "동대문구", "동작구", "서대문구","성동구","영등포구","은평구","종로구","서울교통공사"],
        "전라남도" : ["강진군" , "광양시", "구례군", "담양군", "보성군", "순천시","여수시","함평군","해남군"],
        "전라북도" : ["전라북도" , "군산시", "남원시", "무주군", "순창군", "임실군","장수군","정읍시","전주시시설관리공단"],
        "충청남도" : ["충청남도" , "보령시", "부여군", "서천군", "예산군", "청양군","태안군"],
        "충청북도" : ["충청북도" , "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "천안시", "충주시"],
        "광주광역시" : ["광주광역시" , "광산구", "서구", "광주광역시도시철도공사"],
        "대구광역시" : ["대구광역시" , "달성군", "서구", "수성구","대구광역시교육청","대구도시공사"],
        "부산광역시" : ["강서구" , "남구", "동구", "동래구","부산진구","북구","사상구" , "사하구", "수영구", "연제구","영도구","해운대구","부산도시공사"],
        "세종특별자치시" : ["세종특별자치시"],
        "인천광역시" : ["계양구" , "계양구","미추홀구", "부평구", "서구","연수구"],
        "대전광역시" : ["대전광역시" , "대덕구", "동구", "서구","유성구","중구"],
        "제주특별자치도" : ["제주특별자치도"],
        "전국" : ["고용노동부" , "과학기술정보통신부", "교육부", "국세청","국토교통부","금융위원회","농림축산식품부" , "보건복지부", "산림청", "산업통상자원부","중소벤처기업부","특허청","행정안전부", "국민연금공단", "도로교통공단", "예금보험공사","한국공항공사","한국관광공사","한국농수산식품유통공사" , "한국동서발전(주)", "한국문화정보원", "한국소방산업기술원","한국소비자원","한국장애인고용공단","한국학중앙연구원"],
        "울산광역시" : ["울산광역시","남구","동구","북구","울주군","울산항만공사"]
    ]
    
    var pick1 : [String] = []
    var pick2 : [String] = []
    
    var pick1Row = 0
    var pick2Row = 0
    
    var keyWord : String = ""
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.picker1.delegate = self
        self.picker1.dataSource = self
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        pick1 = pickData.keys.sorted()
        pick2 = pickData["강원도"]?.sorted() as! [String]
    }
    @IBAction func textField(_ sender: UITextField) {
        keyWord = sender.text!
    }
    @IBAction func pressedButton(_ sender: UIButton) {
        print(keyWord)
        print(pick1[pick1Row])
        print(pick2[pick2Row])
        
    }
    
    
}





//MARK: - Pickerview



extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1 {
             return pick1.count
        }
        return pick2.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picker1 {
            pick1Row = row
             return pick1[row]
        }
        pick2Row = row
        return pick2[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1{
            pick1Row = row
            let pick1Key = pick1[pick1Row]
            pick2 = pickData[pick1Key]!
            picker2.selectRow(0, inComponent: 0, animated: true)
            self.picker2.reloadAllComponents()
            
        }
    }

}

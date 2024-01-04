//
//  ViewController.swift
//  BMIAppAssignment
//
//  Created by Jae hyung Kim on 1/3/24.
//

import UIKit

class ViewController: UIViewController {
//  Kg / 키2승
    let mainText = "BMI Calculator"
    let subText = "당신의 BMI 지수를 알려드립니다."
    let butSubText = ["키가 어떻게 되시나요?","몸무게는 어떻게 되시나요?"]
    let placeH = ["예) 180","예) 65"]
    let randomText = "렌덤으로 BMI 계산하기"
    let resultText = "결과 확인"
    let secualTextFieldNum = 1
    //
    var eyeButtonisAct = true
    //
    var height : Int = 0
    var weight : Int = 0
    
    var resultDic :[Int : Double] = [0:0, 1:0]
     
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var subTextlabel: UILabel!
    @IBOutlet var buttonTextLabelT: [UILabel]!
    @IBOutlet var textField: [UITextField]!
    @IBOutlet var randomTextLabel: UILabel!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var eyeButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    func design(){
        designMain(mainTextLabel)
        designSubT(subTextlabel)
        designListButSub(buttonTextLabelT)
        designTextFList(textField)
        designRandomText(randomTextLabel)
        designResultButton(resultButton)
        designEyeButton(eyeButton,eyeButtonisAct)
    }
    
    func designMain(_ uil: UILabel) {
        uil.text = mainText
        uil.textAlignment = .left
        uil.textColor = .black
        uil.font = .boldSystemFont(ofSize: 28)
    }
    func designSubT(_ uil: UILabel) {
        uil.text = subText
        uil.textAlignment = .left
        uil.textColor = .black
        uil.font = .systemFont(ofSize: 16)
        uil.numberOfLines = 2
    }
    
    func designListButSub(_ uilL: [UILabel]) {
        var count = 0
        for item in uilL {
            item.tag = count
            count += 1
        }
        var temp = butSubText
        // reversed -> <String>
        // reverse -> [String]
        // 이럴수가 왜 그랬을까 개발자 popLast가 앙됨 ㅠ
        // temp.reverse()
        print(temp)
        // print(temp.popLast())
        uilL.forEach{
            designButSubT( $0 , "\(temp.popLast() ?? "Error")")
        }
    }
    
    func designButSubT(_ uil: UILabel ,_ str: String) {
        uil.text = str
        uil.textAlignment = .left
        uil.textColor = .black
        uil.font = .systemFont(ofSize: 16)
        uil.numberOfLines = 1
    }
    func designTextFList(_ uitfL:[UITextField]) {
        var tempTag = 0
        for item in uitfL {
            // item.isUserInteractionEnabled = true
            item.clipsToBounds = true
            item.keyboardType = .numberPad
            item.tag = tempTag
            tempTag += 1
            item.textAlignment = .center
        }
        var temp = placeH
        temp.reverse()
        print(temp)
        uitfL.forEach{designButton($0, "\(temp.popLast() ?? "ERROR2")")}
        
    }
    
    
    func designButton(_ uitf: UITextField, _ str: String) {
        uitf.layer.borderWidth = 1
        uitf.placeholder = str
        uitf.layer.cornerRadius = 20
    }
    
    func designRandomText(_ uil: UILabel){
        uil.text = randomText
        uil.textColor = .red
        uil.font = .systemFont(ofSize: 12)
        uil.isUserInteractionEnabled = true
    }
    
    func designResultButton(_ uib: UIButton) {
        uib.setTitle(resultText, for: .normal)
        uib.backgroundColor = UIColor(red: 150 / 255, green: 27 / 255, blue: 240 / 255, alpha: 1)
        uib.setTitleColor(.white, for: .normal)
        uib.layer.cornerRadius = 12
    }
    func designSecuText(_ uit: UITextField) {
        uit.isSecureTextEntry = eyeButtonisAct
    }
    
    func designEyeButton(_ uib:UIButton, _ b: Bool) {
        if b{
            uib.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            uib.tintColor = .black
            uib.backgroundColor = .clear
        }else {
            uib.setImage(UIImage(systemName: "eye"), for: .normal)
            uib.tintColor = .gray
            uib.backgroundColor = .clear
            
        }
    }
    func isOverThree(_ uitf: UITextField) -> Bool {
        if uitf.text?.count ?? 0 < 4{
            return false
        }else {
            return true
        }
    }
    func chagedNum(_ uitf: UITextField) {
        // var tempList : [Int] = []
        testIsNum(uitf)
        maxThree(uitf, isOverThree(uitf))
    }
    
    // prefix / suffix 활용
    func maxThree(_ uitf: UITextField,_ b:Bool) {
        if b{
            // var temp = uitf.text
            // 옵셔널 반환
            //print(temp)
            if let temp = uitf.text {
                print("왜 안나와")
                print(String(temp.suffix(3)))
                uitf.text = String(temp.suffix(3))
            }
        }
        
    }
    
    func testIsNum(_ uitf: UITextField) {
        var tempText = ""
        tempText = uitf.text ?? ""
        // print(tempText.last)
        // 캐릭터를 반환 함으로 스트링 변환후 정수변환해야함 ㄹㄱㄴ
//        guard let num = Int(tempText.last) else {
//            
//        }
        
        // 이번엔 또 반딧불이 유충 같은 옵셔널 문제
//        Value of optional type 'String.Element?' (aka 'Optional<Character>') must be unwrapped to a value of type 'String.Element' (aka 'Character')
//        guard let num = Int(String(tempText.last)) else {
//            
//        }
        
        // 옵셔널을 두번 풀어주니 보고싶지 않던 옵셔널 문구가 안뜬다
        /*
        if let lastText = tempText.last {
            guard let num = Int(String(lastText)) else {
                // 마지막만 지워주는 함수를 겨우 찾았다
                uitf.text = String(tempText.dropLast())
                return
            }
        } 해당 기능은 거의 사용할 이유가 없다고 판단하여
         자체적으로 주석 처리되었습니다.
         */
        
        guard Int(tempText) != nil else {
            uitf.text = ""
            return
        }
    }
    
    func testResult(_ uitf:UITextField, _ uib: UIButton) {
        if let temp = uitf.text {
            guard let te = Int(temp) else {
                print("결과쪽 형변환 문제")
                return
            }
            if te > 250 || te < 40 {
                designAlert1(title: "사람이 아닙니다.", message: "숫자를 확인 해주세요")
            } else {
                resultDic[uitf.tag] = Double(te)
            }
        }
        
    }
    
    func AccessResult() {
        if let height = resultDic[0], let weight = resultDic[1] {
                let bmi = CalcBmi(height: height, weight: weight)
                let message = "BMI : \(bmi)"
                designAlert2(title: "BMI 결과", message: message)
            } else {
                designAlert2(title: "오류", message: "데이터가 누락되었습니다.")
            }
    }
    
    // 현재는 중복되는 코드라도 후에 가서 수정을 위해
    // 분리
    func designAlert1(title:String, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(success)
        
        present(alert, animated: true)
    }
    
    func designAlert2(title:String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        alert.addAction(success)
        
        present(alert, animated: true)
    }
    
    func CalcBmi(height: Double, weight:Double ) -> Double {
        var result = weight / ((height/100) * (height/100)) * 100
        result.round()
        print(result)
        return result / 100
    }
    
    
    @IBAction func eyeButtonAct(_ sender: UIButton) {
        eyeButtonisAct = !eyeButtonisAct
        designEyeButton(eyeButton, eyeButtonisAct)
        designSecuText(textField[secualTextFieldNum])
    }
    
    @IBAction func insertTextField(_ sender: UITextField) {
        // print("??")
        chagedNum(sender)
        
        print(sender.tag)
    }
    @IBAction func resultAct(_ sender: UIButton) {
        // 계산식 ->  키2승 / kg
        //textField.forEach()
        //designAlert(title: <#T##String#>, message: <#T##String#>)
        textField.forEach{
            testResult( $0, sender)
        }
        AccessResult()
        
    }
    
    // 리턴키 없음 레잔도
    @IBAction func returnKeyBoard(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    
    @IBAction func stopView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func randomTouch(_ sender: UITapGestureRecognizer) {
       
    }
    
    @IBAction func randomTouchs(_ sender: UITapGestureRecognizer) {
        print("test2")
        for item in resultDic {
            print(item)
            // item = let 안됨
            //item.value = Double(Int.random(in: 50...200))
        }
        for i in resultDic.keys{
            resultDic[i] = Double(Int.random(in: 50...200))
        }
        // resultDic[1] = Double(Int.random(in: 40...120))
//        textField[0].text = String(Int(resultDic[0]!))
//        textField[1].text = String(resultDic[1]!)
//        
        for i in 0...resultDic.count-1 {
            textField[i].text = String(Int(resultDic[i]!))
        }
    }
    
}


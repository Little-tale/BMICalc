//
//  ViewController.swift
//  BMIAppAssignment
//
//

import UIKit

class ViewController: UIViewController {
    //  Kg / 키2승
    let mainText = "BMI Calculator"
    let subText = "당신의 BMI 지수를 알려드립니다."
    let butSubText = ["닉네임 지어주세요~","키가 어떻게 되시나요?","몸무게는 어떻게 되시나요?"]
    let placeH = ["예) 180","예) 65","예) 개똥이"]
    let randomText = "렌덤 BMI 계산"
    let resultText = "결과 확인"
    var resultV = [0:"저체중", 1:"정상",2:"과체중",3:"비만",4:"고도비만"]
    
    var randomNicList = ["그라만","안돼~","딕셔너리는","순서가 없잖아~","생각을","해보고","코드를","넣어보자"]
    let secualTextFieldNum = 1
    //
    var eyeButtonisAct = true
    //
    var height : Int = 0
    var weight : Int = 0
    
    let defaultKey = ["키","몸무게","닉네임"]
    
    var resultDic :[Int : Double] = [0:0, 1:0]
    // 키 무게 닉
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var subTextlabel: UILabel!
    @IBOutlet var buttonTextLabelT: [UILabel]!
    @IBOutlet var textField: [UITextField]!
    @IBOutlet var randomTextLabel: UILabel!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var eyeButton: UIButton!
    // @IBOutlet var nickNameTextField: UITextField!
    
    @IBOutlet var randomNicMakeLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(defaultKey)
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
        setSaveTextField()
        designRandomLabel(randomNicMakeLabel)
        designResetButton(uib: resetButton)
    }
    func designRandomLabel(_ uil:UILabel) {
        uil.font = .systemFont(ofSize: 12)
        uil.textColor = .blue
        uil.text = "닉네임 생성기"
        uil.isUserInteractionEnabled = true
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
            print(item.tag)
            // item.isUserInteractionEnabled = true
            item.clipsToBounds = true
            item.keyboardType = .numberPad
            item.tag = tempTag
            tempTag += 1
            item.textAlignment = .center
            // 닉네임 부분 예외처리
            if (item.tag == 2) {
                item.keyboardType = .default
            }
        }
        //
        var temp = placeH
        temp.reverse()
        print(temp)
        uitfL.forEach{designButton($0, "\(temp.popLast() ?? "ERROR2")")}
        
    }
    
    
    func designButton(_ uitf: UITextField, _ str: String) {
        uitf.layer.borderWidth = 1
        uitf.placeholder = str
        uitf.layer.cornerRadius = 20
        
        if (uitf.tag == 2) {
            uitf.layer.cornerRadius = 10
        }
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
    
    // 이유는 모르겠으나 Equal height를 주었음에도
    // 크기가 다름 일단 강제적으로 시도
    // 알고보니 비율을 1로 안줌
    func designResetButton( uib: UIButton) {
        uib.setTitle("RESET", for: .normal)
        uib.backgroundColor = UIColor(.red)
        uib.setTitleColor(.white, for: .normal)
        uib.layer.cornerRadius = 12
        uib.tintColor = .black
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
        
        // 로직중 닉네임 부분에서 숫자가 아니라 아마도 저장이 잠깐
        
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
            print("Test -> 키\(height)")
            print("Test -> 무게\(weight)")
            let bmi = CalcBmi(height: height, weight: weight)
            let message = "BMI : \(bmi)"
            var test = ""
            
            switch bmi {
            case 0 :
                test = "값이 없습니다."
            case 1...18.5 :
                test = resultV[0]!
            case 18.5...22.99 :
                test = resultV[1]!
            case 23.0...24.99 :
                test = resultV[2]!
            case 25.0...29.99 :
                test = resultV[3]!
            case 30... :
                test = resultV[4]!
            default :
                test = "Error"
            }
            
            designAlert2(title: test, message: message)
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
    
    func saveTextField() {
        var temp = defaultKey
        temp.reverse()
        for i in textField {
            print(i.text! + "\(temp)")
            UserDefaults.standard.set(i.text, forKey: temp.popLast()!)
        }
        print(" 저장값 테스트 : " + (UserDefaults.standard.string(forKey: "키") ?? ""))
        print(" 저장값 테스트 : " + (UserDefaults.standard.string(forKey: "몸무게") ?? ""))
        print(" 저장값 테스트 : " + (UserDefaults.standard.string(forKey:"닉네임") ?? "진짜?"))
    }
    func setSaveTextField() {
        var temp = defaultKey
        temp.reverse()
        /*
        for i in textField {
            i.text = UserDefaults.standard.string(forKey: temp.popLast() ?? "Test")
        }
        */
        for i in textField {
            guard let key = temp.popLast() else {
                print("setSaveTextField Error")
                return
            }
            i.text = UserDefaults.standard.string(forKey: key)
        }
    }
    // 리셋 해주는 함수
    @objc func resetData() {
        for key in defaultKey {
            UserDefaults.standard.removeObject(forKey: key)
        }
        for uitf in textField {
            uitf.text = ""
        }
    }
    
    func designResetAlert(){
        let alert = UIAlertController(title: "삭제 하시겠습니까?", message: "저장된 데이터가 삭제됩니다.", preferredStyle: .alert)
        let success = UIAlertAction(title: "삭제", style: .destructive,handler: {action in self.resetData()} )
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true)
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
        saveTextField()
    }
    
    // 리턴키 없음 레잔도
    @IBAction func returnKeyBoard(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func stopView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
    
        for i in textField {
            if (i.tag != 2) {
                textField[i.tag].text = String(Int(resultDic[i.tag]!))
                print(textField[i.tag].text!)
            }
        }
        
    }
    // 랜덤닉네임
    @IBAction func randomNicTap(_ sender: UITapGestureRecognizer) {
        for i in textField {
            if (i.tag == 2) {
                i.text = randomNicList.randomElement()
            }
        }
    }
    @IBAction func resetButtonAct(_ sender: UIButton) {
       designResetAlert()
    }
    
    
    
    
}


import Foundation

func main() {
    
    do {
        
        let input = try InputView.ask(about: "분석할 JSON 데이터를 입력하세요.")
        let data = try JSONParser.parse(JSON: input)
        OutputView.printTypeCount(data: data)
        
    } catch {
        print(error)
    }
    
    
}
while true {
    main()
}


// 분석할 JSON 데이터를 입력하세요.
// [ 10, 21, 4, 314, 99, 0, 72 ]
// 총 7개의 데이터 중에 숫자 7개가 포함되어 있습니다.
//
// 분석할 JSON 데이터를 입력하세요.
// [ 10, "jk", 4, "314", 99, "crong", false ]
// 총 7개의 데이터 중에 문자열 3개, 숫자 3개, 부울 1개가 포함되어 있습니다.

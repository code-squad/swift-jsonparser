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

main()

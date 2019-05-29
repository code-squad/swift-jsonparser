import Foundation

func main() {
    
    let input = InputView.ask(about: "분석할 JSON 데이터를 입력하세요.")

    do {
        
        let data = try Parser.parseValue(input)
        OutputView.showDescription(data: data)
        OutputView.showSerializedJSON(data: data)
    } catch {
        print(error)
    }

}

main()



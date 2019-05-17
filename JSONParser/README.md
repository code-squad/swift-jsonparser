# STEP 7. JSON 문자열 분석기

## :pushpin: Step 7-1 : 단순 List 분석

### 구조

1. 입력받기 InputView

2. token으로 나누어 String 배열로 반환하기 : Tokenizer

   공백, 쉼표 기준으로 나눈다

3. Parser - type 알아내서 JSONValue instance 생성하기

   JSONValueFactory 사용

   - true/false: string 맞는지 확인
   - String - starts with " (double quotation)
   - Number 

 4. OuputViw - 출력

 5. TypeCounter - JSONValue Array에 bool, string, number type의 요소가 각각 몇개인지 반환

 6. JSONValue - JSON에서 value가 될 수 있는 type의 자격을 명세한 프로토콜

 7. JSONSymbol - JSON 문자열에서 필요한 문자 상수 저장용



### 참조

https://www.bsidesoft.com/?p=7760






# STEP 7. JSON 문자열 분석기

## :pushpin: Step 7-1 : 단순 List 분석

### 구조

1. 입력받기 `InputView`

2. token으로 나누어 String 배열로 반환하기 : `Tokenizer`
   - 쉼표(comma ,) 도 token으로 나누기 위해, 모든 comma→commaWithBlank(" ,")로 바꾼다
   - **공백**으로 전체 string을 나누어 String 배열로 만든다.

3. `Parser` - type 알아내서 JSONValue instance 생성하기

   `JSONValueFactory` 사용

   - true/false: string 맞는지 확인
   - String - starts with " (double quotation)
   - Number 

 4. `OutputView` - 출력

 5. `TypeCounter` - JSONValue Array에 bool, string, number type의 요소가 각각 몇 개인지 반환

 6. `JSONValue` - JSON에서 value가 될 수 있는 type의 자격을 명세한 프로토콜

    - Bool
    - String
    - Int
    - Array\<JSONValue> : JSONValue protocol 을 준수하는 type을 element로 하는 배열도 JSONValue가 된다. 

 7. `JSONSymbols` - JSON 문자열에서 필요한 문자 상수 저장용

    모든 symbol 은 String으로 통일할 것

&nbsp;

### 참조

- [JSON 개요](https://www.json.org/json-ko.html)

- [ json parser in java](https://github.com/billdavidson/JSONUtil/blob/trunk/JSONUtil/src/main/java/org/kopitubruk/util/json/JSONParser.java)

&nbsp;

&nbsp;

## 📌 Step 7-2 : Object 분석

### 추가/수정된 구조

1.  `Tokenizer` - `tokenize()` method

   - 쉼표(comma ,) 도 token으로 나누기 위해, 모든 comma→commaWithBlank(" ,")로 바꾼다

   - tokenize 방법 - **공백**

     1. 한 character 씩 읽어서 token string 에 덧붙인다

     2. 공백을 만났을 때, string 안이 아니면 append, 아니면 계속한다.

        (이유: value 가 문자열일 경우 문자열 내에 공백이 있을 수 있음 ex. "Dana Lee")

3. `Parser` - type 알아내서 `JSONValue` instance 생성하기

   - 시작 문자에 따라 적절한 `JSONValue` instance 생성
  - { : object / [ : array / 그외 : 일반 value
   - 각각의 생성하는 method 내에서도 `JSONValue`를 생성할 수 있음

3. `JSONObject`, `JSONArray` type 생성

   - standard libarary 의 array를 쓰려고 했으나, json array의 특성만을 다룰 수 있게 따로 구조체로 만들어 내부 array propery를 조작하는 것이 적절하다고 판단

4. `JSONValue` conformance - JSONObject, JSONArray에 추가

5. `TypeCountable` protocol 추가 : Type count 하는데 필요한 자격요건을 명시

   - property 2개 준수해야 함
     - `elementCount`
     - `elements`
   - `JSONArray`, `JSONObject` 만 채택함

6. `TypeCounter` - TypeCountable 의 속성을 사용하여, element의 type과 개수를 구한다

   - type 별 count는 Dictionary 를 사용해서 구현함

   ```swift
   static func getTotalTypeCount(of value: JSONValue & TypeCountable) -> [String : Int] {
   	let elements = value.elements
     var typeCount = [String : Int]()
     for element in elements {
       typeCount[element.typeDescription, default: 0] += 1
     }
     return typeCount
   }
   ```

   Dictionary method

   ```swift
   subscript(Key, default: () -> Value) -> Value
   ```

   주어진 key에 맞는 value를 반환한다. key에 맞는 value가 없을 경우, default value를 마치 있는 것처럼 접근할 수 있다.

7. `TokenReader` : tokenize 완료된 tokens(`Array<String>` type) 을 순서대로 읽는 역할

&nbsp;

### Dictionary

> key-value 쌍을 요소로 가지는 collection 자료구조

```swift
struct Dictionary<Key, Value> where Key : Hashable
```

```swift
let midtermScores :[String : Int] = ["Dana": 100, "Kate" : 90]

print(midtermScores["Dana"]) //100
print(midtermScores["Kate"]) //90
```

&nbsp;

### :mag:

1. for 문에서 string : character 하나하나에 접근 가능

   ```swift
   let greet = "hi"
   
   for character in greet {
   	print(character)
   }
   // "h"
   // "i"
   ```

2. for 문에서 dictionary → tuple

   ```swift
   // OutputView struct
   let totalTypeCountPair = TypeCounter.getTotalTypeCount(of: value)
   for (typeDescription, count) in totalTypeCountPair {
   	typeCountDescription += " \(typeDescription) \(count)개,"
   }
   ```

   `totalTypeCountPair` 는 `[String : Int]` Dictionary 임

3. Dictionary → Array

   Array initializer에 `Sequence` protocol 을 준수하는 type을 전달하면 배열 instance 생성 가능

   Dictionary는 Sequence protocol 준수함.

   ```swift
   // Array
   init<S>(_ elements: S) where S : Sequence, Self.Element == S.Element
   ```

&nbsp;

### Bool - toggle() method

- Bool 값을 true→false, false → true 로 바꿔주는 method

- toggle - 상태 값이 2개뿐이고 계속 state를 그 안에서 바꾼다는 의미

- toggle means something like *switch* - have two states. Bool has two states - true or false

- *Example* :  flag 변수 값 바꾸기

  ```swift
  var flag = true
  
  flag = !flags
  flag.toggle()
  ```

  같은 뜻

&nbsp;

### Generic type - Conditionally Conforms to Protocol

```swift
extension Array: JSONValue where Element: JSONValue {}
extension Array: JSONValue where Element == JSONValue{}

Array<JSONValue>() // JSONValue 가 아님
```

solution - [protocol doesn't conform to itself](https://stackoverflow.com/questions/33112559/protocol-doesnt-conform-to-itself)

(정리 예정)

&nbsp;

### Example

```
{ "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
```

```
[ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
```

```
{ "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : [ "hana", "hayul", "haun" ] }
```

```
[ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
```



### 참조

- [Dictionary](https://developer.apple.com/documentation/swift/dictionary)

&nbsp;

## 📌 Step 7-3 : 규칙 검사하기

### 정규표현식

- 반복
  - `n+` : 앞의 문자가 0번 이상 반복
  - `n*` : 앞의 문자가 1번 이상 반복
- `^n` : ~로 시작
- `n$` : ~로 끝난다
- whitespace `\s` == `[ \t\r\n\f]`
  - space, tabe, line break, form feed..
- 숫자 `\d` == `[0-9]`
- word like character `\w` == 숫자, 글자, _(underscore)
- `(x|y|x)` : OR operation
- `()` capturing group 



```
//object { string : jsonvalue (, string : jsonvalue) } 형태
\{\s*\"[\w\s]+\"\s*\:\s*(true|false|\"[\w\s]*\"|[\d]+)\s*((?:,\s*\"[\w\s]+\"\s*\:\s*(true|false|\"[\w\s]*\"|[\d]+))*)\s*\}

//공백은 0개 이상 있을 수 있다.
\s*

// string ""안에 \w(문자,숫자),\s(공백) 들어갈 수 있음. key는 ""(emptystring) 안되게 함(1개 이상)
"[\w\s]+"

// jsonvalue - 3개 유형 중 하나
// true / false
// number : \d, 1개 이상.
// string : "" 안에 문자,숫자,공백. 0개 이상
(true|false|\"[\w\s]*\"|[\d]+)

// (, string : jsonvalue) 0개 이상 반복
// non-capturing 사용 (?: ~~~)
// ((반복되는 부분)*) 다시 감싸줘야 됨
```



#### 특수 기호 in swift

- swift 에서는 특수기호 앞에 `\` 붙어야 됨.
- regex 에서 `\` 와 같이 쓰이는 기호는 두개 붙여야 됨..
- Swift == regex
  - `\.` == `.` 
  -  `\\.` == `\.`

&nbsp;

#### 유의할 점

- 정규표현식에서 사용되는 문자 이외에는 모두 앞에 `\\` 를 붙여줘야 함 (`\\{`)
- 원래 `\`랑 같이 쓰이는건 `\\`로 바꿔야 함
- double quotation 은 `\"`

```
// swift pattern for json object
"\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}"


// swift pattern for json array
"\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\]"


// array element 에 jsonobject 추가
"\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\})\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}))*)\\s*\\]"

// object element 에 array 추가
"\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\])\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\]))*)\\s*\\}"

```



(참조) JSON String 

![JSON String](https://www.json.org/string.gif)

&nbsp;

### NSRegularExpression 사용하기

regex pattern 에 매치되는지 확인할 때 사용

- init : pattern과 option 설정

- `matches` method  

  - input : pattern 검사될 string, 검사될 string의 range(`NSRange`)
  - output : 매치된 문자열들 -  `[NSTextCheckingResult]`

- `NSTextCheckingResult`

  > An occurrence of textual content found during the analysis of a block of text, such as when matching a regular expression.

  - `var range: NSRange` : Returns the range of the result that the receiver represents.

    받은 표현(input string)에서 매치된 부분의 범위!

  - `NSRange` → `Range` 로 변경해서 input의 substring 을 구하면 됨

    - `String(input[range])`

&nbsp;

### 요구사항

```
- 사용자가 입력한 JSON 데이터 문자열 문법 검사를 담당하는 GrammarChecker 구조체를 추가한다.
- JSON 표준 문법에 맞는지 검사한다.
- 현재 지원하는 JSON 형식 외에 다른 구조에 대해서도 판단하도록 구현한다.
  - 예를 들어, JSON 객체 내에 배열이나 객체가 중첩해서 포함된 경우는 걸러낸다. 
  - 스위프트 파운데이션에 포함된 정규 표현식 처리 클래스를 적극 활용한다. NSRegularExpression
```

- object - value : string, number, bool

  ```
  "^\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}$"
  ```

- array element 로 object 는 허용 (string, number, bool, object)

  ```
  "^\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\})\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}))*)\\s*\\]$"
  ```

  
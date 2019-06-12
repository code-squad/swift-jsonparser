## JSON 문자열 분석기



##  JSON

**JSON**: Java Script Object Notation

- [속성-값 쌍](https://ko.wikipedia.org/w/index.php?title=속성-값_쌍&action=edit&redlink=1)( attribute–value pairs and array data types (or any other serializable value)) 또는 "키-값 쌍"으로 이루어진 데이터 오브젝트를 전달하기 위해 인간이 읽을 수 있는 텍스트를 사용하는 [개방형 표준](https://ko.wikipedia.org/wiki/개방형_표준) 포맷이다.
- [인터넷](https://ko.wikipedia.org/wiki/인터넷)에서 자료를 주고 받을 때 그 자료를 표현하는 방법이다.



## STEP-1. 단순 List 분석



![array](https://www.json.org/array.gif)



```
분석할 JSON 데이터를 입력하세요.
[ 10, "jk", 4, "314", 99, "crong", false ]
총 7개의 데이터 중에 문자열 3개, 숫자 3개, 부울 1개가 포함되어 있습니다.
```



### 🏗 전체 구조

- `InputView` : 입력

<br/>

- `Tokenizer`: `,`로 입력문자열을 구분
- `Parser`: 토큰을 `JSONValueType` 배열에 저장 //`JSONValueType`: `String`, `Number`, `Bool` 타입
- `Converter`: 토큰의 타입을 확인해서 해당 타입으로 변환
- `TypeCounter`: `JSONValueType`배열에서 타입의 개수를 카운트

<br/>

- `OutputView`: 출력

---

<br/>

## STEP-2.  Object 분석



![object](https://www.json.org/object.gif)



```
분석할 JSON 데이터를 입력하세요.
{ "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }
총 4개의 객체 데이터 중에 문자열 2개, 숫자 1개, 부울 1개가 포함되어 있습니다.

분석할 JSON 데이터를 입력하세요.
[ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }, 
{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]
총 2개의 배열 데이터 중에 객체 2개가 포함되어 있습니다.
```



### 🏗 전체 구조

- `InputView` : 입력

<br/>

- `JSONValueType`: JSON Value가 될 수 있는 타입.
  - `typeDescription`으로 자신의 타입을 설명
  - `TypeCountable`: 컨테이너들은 element들의 총 개수와 어떤 value 타입이 각각 몇 개 있는지 알아야 함   
  - `JSONContainerType`: `JSONValueType & TypeCountable`

- `Tokenizer`: `ws`, ` ,`로 입력문자열을 구분 → 토큰화
- `Parser`: `nextToken()`으로 다음 토큰을 읽어오면서 `JSONContainerType` 으로 파싱 //`JSONContainerType`: `Object`, `Array` 타입
  - `Object` 타입인 경우 `parseObject()`
    - `:` 를 기준으로 key, value 로 구분해서 `[String: JSONValueType]` 으로 생성
  - `Array` 타입인 경우 `parseArray()`
    - `Object`를 만날 경우 `parseObject()` 한 결과를 `[JSONValueType]` 배열에 추가
    - 아닌 경우 `makeJSONType()`으로 `[JSONValueType]` 배열에 추가

- `Converter`: 토큰의 타입을 확인해서 해당 타입으로 변환 //`String`, `Number`, `Bool` 타입

<br/>

- `OutputView`: 출력

 

### JSON Lexical Structure (simply)

```
object
	'{' ws '}'
	'{' members '}'

members
	member
	member ',' member

member
	ws string ws ':' ws element

string
	"characters"

array
	'[' ws ']'
	'[' elements ']'

elements
	element
	element ',' element

element
	ws value ws
```

- JSON 객체 값(value)에 포함될 수 있는 데이터는 문자열(String), 숫자(Number), 부울 true/false(Bool) 만 있다.

- 단, JSON 배열 내부에는 객체가 포함될 수 있다고 가정한다.



### Input Format Analysis

```
'{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}'
'{' ws "name" ws ':' ws "CHO MINJI" ',' ws "level" ws ':' ws 2 ws '}'
```

```
'[' ws '{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}' ',' ws '{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}' ws ']'
```



-  `ws` , `,` 를 기준으로 JSON value가 구분된다. 
   -   `ws` , `,` 를 기준으로 나눠서 토큰화한다.
- 문자열의 경우 `ws`, `,` 가 포함 되어 있을 수 있다. 
  - 토큰을 생성할 때, `"CHO MINJI"` 가 아니라  `"CHO` , `MINJI"` 와 같이 오류가 발생할 수 있다.
  - `isInString` 을 사용하여 `"` 의 짝이 맞춰질 때 까지 delimiter를 무시하고 한 토큰으로 묶는다.



```swift
분석할 JSON 데이터를 입력하세요.
{ "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false }

[
"{", 
"\"name\"", ":", "\"MINJI CHO\"", 
"\"alias\"", ":", "\"mindy\"", 
"\"level\"", ":", "2", 
"\"married\"", ":", "false", 
"}"
]

분석할 JSON 데이터를 입력하세요.
[ { "name" : "MINJI CHO", "alias" : "mindy", "level" : 2, "married" : false },{ "name" : "HELLO HI", "alias" : "hi", "level" : 4, "married" : true } ]

[
"[", 
"{",
"\"name\"", ":", "\"MINJI CHO\"", 
"\"alias\"", ":", "\"mindy\"", 
"\"level\"", ":", "2", 
"\"married\"", ":", "false", 
"}", 
"{", 
"\"name\"", ":", "\"HELLO HI\"", 
"\"alias\"", ":", "\"hi\"", 
"\"level\"", ":", "4", 
"\"married\"", ":", "true", 
"}", 
"]"
]
```

- 배열과 객체를 구분해서 출력해야 한다.
  - 배열 키워드 (`[`, `]`) : LeftSquareBracket, RightSquareBracket
  - 객체 키워드 (`{`,  `}`): LeftCurlyBracket, RightCurlyBracket
  - 두 컨테이너를 구분하기 위해 Bracket도 Token화 한다.



<br/>

## Dictionary 란?

>  데이터를 키와 값의 쌍으로 담아두는 컬렉션타입

[Dictionary 기본 사용법 정리](https://github.com/cmindy/TIL/blob/master/Swift/Dictionary.md)



#### subscript(_:default:)

Accesses the value with the given key. If the dictionary doesn’t contain the given key, accesses the provided default value as if the key and default value existed in the dictionary.

지정된 키를 사용하여 값에 액세스한다. 사전에 제공된 키가 딕셔너리에 없을 때도 마치 키와 값이 딕셔너리에 있는 것처럼 지정한 default 값에 접근한다.

```swift
var countDescription: [String: Int] {
        var counts: [String: Int] = [:]
        for (key, value) in self {
            counts[value.typeDescription, default: 0] += 1
        }
        return counts
    }
```



---

### Reference

https://json.org

https://developer.apple.com/documentation/swift/dictionary/2885650-subscript


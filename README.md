## JSON 문자열 분석기



## JSON

JSON: Java Script Object Notation

- [속성-값 쌍](https://ko.wikipedia.org/w/index.php?title=속성-값_쌍&action=edit&redlink=1)( attribute–value pairs and array data types (or any other serializable value)) 또는 "키-값 쌍"으로 이루어진 데이터 오브젝트를 전달하기 위해 인간이 읽을 수 있는 텍스트를 사용하는 [개방형 표준](https://ko.wikipedia.org/wiki/개방형_표준) 포맷이다.
- [인터넷](https://ko.wikipedia.org/wiki/인터넷)에서 자료를 주고 받을 때 그 자료를 표현하는 방법이다.



## STEP-1 단순 List 분석



![array](https://www.json.org/array.gif)



```
분석할 JSON 데이터를 입력하세요.
[ 10, "jk", 4, "314", 99, "crong", false ]
총 7개의 데이터 중에 문자열 3개, 숫자 3개, 부울 1개가 포함되어 있습니다.
```



- `InputView` : 입력

------

- `Tokenizer`: `,`로 입력문자열을 구분
- `Parser`: 토큰을 `JSONValueType` 배열에 저장 //`JSONValueType`: 문자열, 숫자, 부울 타입
- `Converter`: 토큰의 타입을 확인해서 해당 타입으로 변환
- `TypeCounter`: `JSONValueType`배열에서 타입의 개수를 카운트

------

- `OutputView`: 출력



## STEP-2  Object 분석



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

value에는 문자열, 숫자, 부울만 있다고 가정한다.



```
'{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}'
'{' ws "name" ws ':' ws "CHO MINJI" ',' ws "level" ws ':' ws 2 ws '}'
```

```
'[' ws '{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}' ',' ws '{' ws "characters" ws ':' ws value ',' ws "characters" ws ':' ws value ws '}' ws ']'
```



-  `ws` , `,` 를 기준으로 토큰을 생성한다.
- 문자열의 경우 `ws`, `,` 가 포함 되어 있을 수 있다. 
  - 토큰을 생성할 때, `"CHO MINJI"` 가 아니라  `"CHO`  `MINJI"` 와 같이 오류가 발생할 수 있다.
  - `isInString` 을 사용하여 `"` 의 짝이 맞춰질 때 까지 delimiter를 무시하고 한 토큰으로 묶는다.



---

### Reference

https://json.org
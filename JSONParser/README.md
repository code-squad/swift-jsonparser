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

### Example

```
{ "name" : "KIMJUNG", "alias" : "JK", "level" : 5, "married" : true }
```

```
[ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
```

```
{ "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : [ "hana", "hayul", "haun" ] }
```

&nbsp;

### 참조

- [String]
- [Dictionary](https://developer.apple.com/documentation/swift/dictionary)

---
layout: post
title: java 만능 DateUtil 만들기
categories: study
---

## LocalDate 와 LocalDateTime 그리고 DateTimeFormatter

* LocalDate
> API : https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html

* LocalDateTime
> API : https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html

* DateTimeFormatter
> API : https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html

---
## 사용

문서의 수정일/생성일이나 메일의 발신일이 다양한 패턴으로 들어오는 경우가 있었다.

이러한 패턴들을 그대로 문자열로 보여주기보다
실제 Date 로 파싱하여 그대로 쓰거나
다시 내가 원하는 패턴으로 재가공 시켜주려 한다.

그럴려면 모든 패턴을 읽어서 Date 객체화 시켜야 한다고 생각했다.

### 첫번째로, 날짜/일시 개념으로 2가지로 나누었다.
1. 년월일 -> LocalDate
2. 년월일시분초 -> LocalDateTime

### 보이는 패턴들을 추출했다.
 -> 이건 계속 되어야 할 작업
  -> DateTimeParseException 등으로 예외처리하여 패턴에 안잡히는 일시 정보를 찍어서 처리하곤 했다..
  
### 소스 작성
+ 다양한 패턴으로 들어오는 날짜 문자열 -> 날짜(일시)를 읽어서 내가 원하는 특정 패턴 문자열로 반환
+ 띄어쓰기가 제 각각으로 들어오거나 괄호 등 특이 케이스 처리를 위해 정규표현식 작성하여 불필요한 특수문자 제거
+ 영문이 있으면 로케일 변경
```
private final static String[] dateFormats = new String[] {
  "yyyyMMdd",
  "yyyy.MM.dd",
  "yyyy.M.d", // 1999.4.5
  "yyyy년MM월dd일",
  "yyyy년MM월dd일E요일",
  "EddyyyyMMM",
  "EEEMMMddyyyy"  // ex. Wed Dec 22 1999
}

private final static String[] timeFormats = new String[] {
  "yyyyMMddHHmmss",
  "yyyyMMddahmmss", //a-> 오전/오후
  "yyyy년MM월dd일E요일HH시mm분",
  "yyyy년M월d일h시m분",
  "yyyy년MM월dd일E요일HH시mm분",
  "EEEEddMMMMyyyyhhmmssa", //Friday 22 July 2016 10 06:48AM
  "MMMMddyyyyHHmm", // February 13 2015 10:44
  "EEEMMMddHHmmssyyyy" // Thu Nov 27 13 08 25 2003
}

public static String dateParse(String dateStr){
  if(dateStr.length() <1) return "";
  
  Locale lo = Locale.KOREA;
  if(dateStr.matches(".*?[a-zA-z].*?"))
    lo = Locale.ENGLISH;
  
  
  String removePattern = "\\,|\\-|\\:|\\s|\\(|\\)" ; //  => , - : 공백 ()
  dateStr = dateStr.replaceAll(removePattern, "");
  String toFormat = "yyyyMMddHHmmss";
  
  LocalDate ld = null;
  LocalDateTime ldt = null;
  for(String f : dateFormats){
    try{
      DateTimeFormatter form = DateTimeFormatter.ofPattern(f).withLocale(lo);
      ld = LocalDate.parse(dateStr, form);
      break;
    }catch(DateTimeParseException e){
      //인식 못하는 패턴 로그 남김
    }
  }
  
  if(ld != null)
    dateStr = ld.format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "000000"; // 시간이 없는 문자열은 0으로 채움
 
 
  for(String f: timeFormats){
    try{
      DateTimeFormatter form = DataeTimeFormatter.ofPattern(f).withLocale(lo);
      ldt = LocalDateTime.parse(dateStr, form);
      break;
    }catch(DateTimeParseException e){
      //인식 못하는 패턴 로그 남김
    }
  }
  
  if(ldt != null)
    return ldt.format(DateTimeFormatter.ofPattern(toFormat));
  else
    return "";
}

```



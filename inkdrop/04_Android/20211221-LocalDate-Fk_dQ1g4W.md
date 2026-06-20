# LocalDate


Dateの計算が簡単になりそう。
https://codechacha.com/ja/java-examples-current-date-and-time/
https://stackoverflow.com/questions/1636038/time-how-to-get-the-next-friday

https://qiita.com/orimomo/items/c15fff517701a56b0cd9

```java
LocalDate now = LocalDate.now();
LocalDate tuesday = now.with(TemporalAdjusters.next(DayOfWeek.TUESDAY));
LocalDate saturday = now.with(TemporalAdjusters.next(DayOfWeek.FRIDAY)); //境界は金曜にする

LocalDate next;
if (tuesday.isAfter(saturday)) {
  next = saturday;
} else {
  next = tuesday;
}

```

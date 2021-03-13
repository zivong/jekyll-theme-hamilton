---
layout: post
toc: true
title: "파이썬으로 업비트 거래하기"
categories: 파이썬으로-업비트-자동매매
---
업비트 API를 wrapping한 파이썬 라이브러리 `pyupbit`를 이용해 업비트 데이터를 불러오고, 주문하는 방법에 대해 알아보겠습니다. 포스트는 [pyupbit github](https://github.com/sharebook-kr/pyupbit) 페이지를 참고하여 작성했습니다. 

## 1. pyupbit 설치하기

pip install을 이용해 간단하게 설치할 수 있습니다.

```bash
$ pip install pyupbit
```

print 결과를 통해 설치가 잘 완료됐는지 확인합니다.
```python
>>> import pyupbit
>>> print(pyupbit.Upbit)
<class 'pyupbit.exchange_api.Upbit'>
```

## 2. 데이터 불러오기

### 2.1 가상화폐 지정하기
어떤 가상화폐 데이터를 사용할 것인지 결정해야합니다.

저는 이더리움 데이터를 불러오고, 거래하는 방법에 대해 설명드리겠습니다.

```python
>>> ticker = "KRW-ETH"
```

`pyupbit`에 입력하는 가상화폐 이름은 거래소 차트 상단에서 확인할 수 있습니다.

<figure>
    <center>
        <img src="/assets/imgs/upbit/ticker_name.png" 
         width="90%" height="90%" alt=""/> 
        <figcaption>가상화폐 이름 확인</figcaption>
    </center>
</figure>

### 2.2 현재 가격 불러오기

현재 가격을 확인합니다.

```python
>>> pyupbit.get_current_price(ticker)
1773000.0
```

### 2.3 캔들 데이터 불러오기

거래소 차트에서 가장 기본으로 보이는 일봉 데이터를 불러오겠습니다.

파이썬에서 함수 호출을 통해 받은 데이터와 거래소 데이터와 같은 것을 확인 할 수 있습니다. (작성시각 2021.02.07 17:05:14) <br>
이후 포스트에서 차트 그래프에서 보이는 이동평균선 데이터를 만드는 법도 소개하겠습니다.

포스트를 작성하는 중간에도 금액이 계속 바뀌고 있습니다. 


```python
>>> pyupbit.get_ohlcv(ticker=ticker, interval="day")
                          open       high        low      close         volume
...                        ...        ...        ...        ...            ...
2021-02-03 09:00:00  1614000.0  1744500.0  1601500.0  1739500.0  240062.011782
2021-02-04 09:00:00  1740000.0  1802500.0  1631000.0  1720000.0  288659.898673
2021-02-05 09:00:00  1720000.0  1856000.0  1720000.0  1817500.0  181397.168857
2021-02-06 09:00:00  1817000.0  1844500.0  1757000.0  1785000.0  162614.563420
2021-02-07 09:00:00  1786000.0  1805500.0  1729500.0  1767500.0   63208.973625

[200 rows x 5 columns]
```

<figure>
    <center>
        <img src="/assets/imgs/upbit/daily_chart.png" 
         width="90%" height="90%" alt=""/> 
        <figcaption>거래소 캔들 차트</figcaption>
    </center>
</figure>

다른 간격의 데이터를 불러오고 싶은 경우 `interval` 값을 바꿔서 사용합니다.

```python
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute1")  # 분봉 데이터
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute3")  # 3분봉 데이터
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute5") 
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute10") 
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute30") 
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute60") 
>>> pyupbit.get_ohlcv(ticker=ticker, interval="minute240") 
>>> pyupbit.get_ohlcv(ticker=ticker, interval="week")  # 월봉 데이터
>>> pyupbit.get_ohlcv(ticker=ticker, interval="month")  # 월봉 데이터
```

## 3. 가상화폐 주문하기

### 3.1 로그인하기

`pyupbit`를 통해 업비트에 로그인 하기 위해서 지난 포스트 [업비트 API 사용하기]({% post_url 2021-01-30-Upbit-API %})에서 발급 받은 Open API  `Access Key`와 `Secret Key` 토큰을 이용합니다.

```python
access_key = "???" 
secret_key = "???"
upbit = pyupbit.Upbit(access_key, secret_key)
```

### 3.2 잔고 조회하기

잔고 조회를 해보겠습니다. 한화로 4만원정도가 있습니다. 라이브러리를 통한 조회가 잘 되고 있음을 알 수 있습니다.

```python
>>> upbit.get_balances()
[{'currency': 'KRW', 'balance': '41521.61907489', 'locked': '0.0', 'avg_buy_price': '0', 'avg_buy_price_modified': True, 'unit_currency': 'KRW'}]
```

<figure>
    <center>
        <img src="/assets/imgs/upbit/balance_1.png" 
         width="50%" height="50%" alt=""/> 
        <figcaption>잔고 조회</figcaption>
    </center>
</figure>


### 3.3 시장가 주문하기 - 매수

이더리움을 1만원 주문해보겠습니다. 이더리움 보유수량이 0ETH에서 0.0057ETH로 증가했습니다.

```python
>>> upbit.buy_market_order(ticker=ticker price=10000)
>>> upbit.get_balances()
[{'currency': 'KRW', 'balance': '31516.62655863', 'locked': '0.0', 'avg_buy_price': '0', 'avg_buy_price_modified': True, 'unit_currency': 'KRW'}, 
{'currency': 'ETH', 'balance': '0.00566893', 'locked': '0.0', 'avg_buy_price': '1764000', 'avg_buy_price_modified': False, 'unit_currency': 'KRW'}]
```

<figure>
    <center>
        <img src="/assets/imgs/upbit/balance_2.png" 
         width="50%" height="50%" alt=""/> 
        <figcaption>잔고 조회 - 이더리움 매수 후</figcaption>
    </center>
</figure>

### 3.4 시장가 주문하기 - 매도

방금 구매한 이더리움을 매도해보겠습니다. 

매수시에는 한화 기준으로 요청하고, 매도시에는 이더리움 수량을 기준으로 요청합니다.

```python
>>> upbit.sell_market_order(ticker=ticker, volume=0.00566)
>>> upbit.get_balances()
[{'currency': 'KRW', 'balance': '41461.93141863', 'locked': '0.0', 'avg_buy_price': '0', 'avg_buy_price_modified': True, 'unit_currency': 'KRW'}, 
{'currency': 'ETH', 'balance': '0.00000893', 'locked': '0.0', 'avg_buy_price': '1764000', 'avg_buy_price_modified': False, 'unit_currency': 'KRW'}]
```

<figure>
    <center>
        <img src="/assets/imgs/upbit/balance_3.png" 
         width="50%" height="50%" alt=""/> 
        <figcaption>잔고 조회 - 이더리움 매도 후</figcaption>
    </center>
</figure>

이번 포스트에서는 `pyupbit` 라이브러리를 활용해 가격을 조회하고, 시장가로 매수/매도 하는 방법에 대해 알아보았습니다. <br>
[다음 포스트]({% post_url 2021-03-13-Automatically-earn-1-percent %})에서는 자동으로 매매하는 python class를 작성해보겠습니다.

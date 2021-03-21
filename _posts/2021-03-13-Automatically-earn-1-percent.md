---
layout: post
toc: true
title: "자동매매로 가상화폐 1퍼센트 수익내기"
categories: 파이썬으로-업비트-자동매매
---

이번 포스트에서는 업비트 API를 wrapping한 파이썬 라이브러리 `pyupbit`를 이용해 자동으로 현재가로 매수하고, 1퍼센트 수익이 생기는 시점에 매도하는 프로그램을 만들어보겠습니다.

전테 코드는 [Github](https://github.com/LEEMINJOO/only-trading-is-life-way/blob/main/src/trader/basic_trader.py)에서 확인 가능합니다.

## 자동매매 Trader 만들기

자동매매를 하기위해서 자동으로 매수와 매도를 하는 Trader를 만들어야 합니다. <br>
Trader는 업비트 API를 이용해 불러온 가상화폐(이하 코인) 가격과 잔고 현황을 알고있어야합니다.


### Trader Class 선언하기

1. init으로 로그인된 upbit 객체와, 구매하고자 하는 가상화폐명을 받습니다.

    ```python
    class BasicTrader:
        def __init__(
            self,
            upbit,
            ticker,
        ):
            self.upbit = upbit
            self.ticker = ticker
    ```

2. 업비트 API을 이용해 한화 잔고`krw_balance`와 가상화폐 잔고`ticker_balance`를 property로 설정합니다.

    ```python
        @property
        def krw_balance(self):
            return self.upbit.get_balance(ticker="KRW")

        @property
        def ticker_balance(self):
            return self.upbit.get_balance(ticker=self.ticker)
    ```

3. `buy` 함수 실행시 한화로 10,000원 시장가에 매수합니다. 단, 한화 잔고가 10,000원 이상이어야 합니다.

    ```python
        def buy(self):
            krw_price = 10000
            if self.krw_balance > krw_price:
                self.upbit.buy_market_order(
                    ticker=self.ticker,
                    price=krw_price,
                )
    ```

4. `sell` 함수 실행시 갖고 있는 가상화폐를 시장가에 모두 매도합니다.

    ```python
        def sell(self):
            self.upbit.sell_market_order(
                ticker=self.ticker,
                volume=self.ticker_balance,
            )
    ```

1, 2, 3, 4 를 모두 결합합니다.

```python
class BasicTrader:
    def __init__(
        self,
        upbit,
        ticker,
    ):
        self.upbit = upbit
        self.ticker = ticker

    @property
    def krw_balance(self):
        return self.upbit.get_balance(ticker="KRW")

    @property
    def ticker_balance(self):
        return self.upbit.get_balance(ticker=self.ticker)

    def buy(self):
        krw_price = 10000
        if self.krw_balance > krw_price:
            self.upbit.buy_market_order(
                ticker=self.ticker,
                price=krw_price,
            )
            print(f"Buy {self.ticker}, KRW: {krw_price}")

    def sell(self):
        self.upbit.sell_market_order(
            ticker=self.ticker,
            volume=self.ticker_balance,
        )
        print(f"Sell {self.ticker}, Ticker: {self.ticker_balance}")

```

만약, 가격과 거개량을 지정하고 싶은 경우 함수를 변경하면 됩니다.

```python
    def buy(self, ticker_price, ticker_volume):
        krw_price = ticker_price * ticker_volume
        if self.krw_balance > krw_price:
            self.upbit.buy_limit_order(
                ticker=self.ticker,
                price=ticker_price,
                volume=ticker_volume,
            )

    def sell(self, ticker_price, ticker_volume):
        self.upbit.sell_limit_order(
            ticker=self.ticker,
            price=ticker_price,
            volume=ticker_volume,
        )

```

### Trader 실행하기

위에서 시장가로 매수/매도 하도록 만든 Trader를 직접 실행해보겠습니다.

1. Trader를 할당합니다.

    ```python
    >>> from pyupbit import Upbit
    >>> access_key = "???" 
    >>> secret_key = "???"
    >>> upbit = Upbit(access_key, secret_key)
    >>> ticker = "KRW-ETH"

    >>> trader = BasicTrader(upbit=upbit, ticker=ticker)
    ```

2. Trader 잔고를 확인합니다.

    ```python
    >>> trader.krw_balance
    >>> trader.ticker_balance
    ```

<figure>
    <center>
        <img src="/assets/imgs/upbit/trader-1.png" 
         width="70%" height="70%" alt=""/> 
        <!-- <figcaption>잔고 조회 - 이더리움 매수 후</figcaption> -->
    </center>
</figure>

3. 시장가로 매수합니다.

    ```python
    >>> trader.buy()
    ```

4. 시장가로 매도합니다.

    ```python
    >>> trader.sell()
    ```

<figure>
    <center>
        <img src="/assets/imgs/upbit/trader-2.png" 
         width="70%" height="70%" alt=""/> 
        <!-- <figcaption>잔고 조회 - 이더리움 매수 후</figcaption> -->
    </center>
</figure>


## 자동매매 Trader로 1퍼센트 수익내기

위에서 만든 Trader를 이용해 매수하고, 1 퍼센트 수익이 났을 때 매도하도록 실행해보겠습니다.

### 평균 매수가격 확인하기

1 퍼센트 수익 여부를 확인하기 위해서 평균 매수가격을 알아야합니다.

전체 잔고를 조회하고, 그 중 설정한 ticker의 정보 중 평균 매수가격을 Trader의 property로 반환합니다.

```python
    @property
    def avg_ticker_price(self):
        balances = self.upbit.get_balances()
        for balance in balances:
            if self.ticker.split('-')[1] == balance['currency']:
                return float(balance['avg_buy_price'])
        return 0.0
```

다시 시장가 매수 후 평균 매수가격을 확인했습니다.

```python
>>> trader.buy()
>>> trader.avg_ticker_price
```

<figure>
    <center>
        <img src="/assets/imgs/upbit/trader-avg-price.png" 
         width="70%" height="70%" alt=""/> 
    </center>
</figure>

### 매도가격 예약하기

원하는 금액으로 매도하기 위해 `sell` 함수를 수정하겠습니다.

```python
    def sell(self, ticker_price, ticker_volume):
        self.upbit.sell_limit_order(
            ticker=self.ticker,
            price=ticker_price,
            volume=ticker_volume,
        )
```

이제 원하는 매도 가격으로 예약할 수 있습니다.

### 1퍼센트 수익내기

이제 평균 매수 가격의 1% 보다 높은 금액으로 매수 예약을 걸어놓고 기다린다면 1% 수익을 받게됩니다! <br>
(이더리움은 1,000원 단위로 주문하기 때문에 반올림이 필요합니다.)

```python
>>> trader.avg_ticker_price
2172000.0
>>> price = trader.avg_ticker_price * (1.01)
>>> price = round(price, -3)
>>> volume = trader.ticker_balance
>>> trader.sell(price, volume)
```

예약이 된 것을 확인 할 수 있습니다. ~~이후 거래 되면 추가 업로드 하겠습니다 ㅎㅎ~~
<figure>
    <center>
        <img src="/assets/imgs/upbit/trader-1-p.jpg" 
         width="50%" height="50%" alt=""/> 
    </center>
</figure>


다음날 새벽에 매도된것을 확인 할 수 있습니다.

<figure>
    <center>
        <img src="/assets/imgs/upbit/1p-conclusion.png" 
         width="50%" height="50%" alt=""/> 
    </center>
</figure>


다음 포스트에서는 잠든 사이에도 자동으로 매수/매도 하는 Trader를 만들어 보기 전에 Trader의 수익률 성능을 확인하기 위한 백테스트를 소개하겠습니다.

전테 코드는 [Github](https://github.com/LEEMINJOO/only-trading-is-life-way/blob/main/src/trader/basic_trader.py)에서 확인 가능합니다.

---
title : "Part 1. Introduction to Ensemble Learning"
category :
  - ML
tag :
  - machine learning
  - Ensemble
  - basic
  - Voting
  - Averaging
  - Bagging
  - Boosting
  - Stacking
sidebar_main : true
author_profile : true
use_math : true
header:
  teaser : https://static1.squarespace.com/static/57dc396a03596e8da9fe6b73/t/57eef283b3db2ba633355a07/1480477568336/UBC_Bands.jpg
  overlay_image : https://static1.squarespace.com/static/57dc396a03596e8da9fe6b73/t/57eef283b3db2ba633355a07/1480477568336/UBC_Bands.jpg
published : true
---
Part 1. What is Ensemble Learning?

## 0. Intro

머신러닝 튜토리얼에 Advanced 알고리즘을 보면 항상 앙상블 학습이라는 내용이 포함되어 있습니다.
최근 캐글 우승자의 인터뷰를 보면 대다수가 앙상블 기법 중 하나를 이용했다고 합니다.

이는 앙상블을 알아야 캐글에서 좋은 성적을 받을 수 있다는 말이기도 합니다.

앙상블 알고리즘에 대해 포스팅은 3개 정도로 나누어 올리겠습니다.
예상으로는 다음과 같이 나눌 수 있을 것 같습니다.

- Part 1. What is Ensemble Learning
- Part 2. Voting & Bagging with Code
- Part 3. Boosting with Code
- Part 4. Stacking with Code

(포스팅을 적으며 목록을 수정했습니다.)

첫 번째 포스팅은 종류와 개념에 대해 다뤄보겠습니다. 구체적인 방법에 대한 내용은 다음 포스팅에서 다루겠습니다.

## 1. What is Ensemble Learning?

<figure>
    <img src = "https://i.imgur.com/pgJG0xq.png">
    <figcaption> Coursera의 How to Win a Data Science Competition: Learn from Top Kagglers의 코스에서 실전 전의 마지막 강의 | 출처 : https://www.coursera.org/learn/competitive-data-science </figcaption>
</figure>

**앙상블(Ensemble)** 학습은 여러 개의 학습 알고리즘을 사용하고, 그 예측을 결합함으로써 보다 정확한 최종 예측을 도출하는 기법입니다. *하나의 강한 머신러닝 알고리즘보다 여러 개의 약한 머신러닝 알고리즘이 낫다* 라는 아이디어를 가지고 이해하면 좋습니다.

이미지, 영상, 음성 등의 비정형 데이터의 분류는 딥러닝이 뛰어난 성능을 보이고 있지만, 대부분의 정형 데이터 분류 시에는 앙상블이 뛰어난 성능을 나타내고 있습니다.

문제와 데이터에 따라 단일 모델의 성능이 더 좋은 경우도 있습니다. 하지만 앙상블 기법을 사용하면 더 유연성있는 모델을 만들며 더 좋은 예측 결과를 기대할 수 있습니다.

캐글에서는 높은 성적을 얻기 위해서 시도해볼 수 있는 테크닉 중 하나이며, 최근 많은 winning solution에서 앙상블 기법이 사용되었습니다.

앙상블 학습의 유형은 가장 많이 알려진 Voting, Bagging, Boosting, Stacking 등이 있으며, 그 외에도 다양한 앙상블 학습의 유형이 있습니다.

## 2. Voting & Averaging

<figure>
    <img src = "https://facingtoday.facinghistory.org/hs-fs/hubfs/Listenwise%20Lower%20Voting%20Age.jpg?width=4606&name=Listenwise%20Lower%20Voting%20Age.jpg">
    <figcaption> 모델들의 투표가 최종 결과가 된다! | 출처 : https://facingtoday.facinghistory.org </figcaption>
</figure>

**보팅(Voting)** 또는 **에버리징(Averaging)** 은 가장 쉬운 앙상블 기법입니다.
이 둘은 서로 다른 알고리즘을 가진 분류기를 결합하는 방식입니다.
Voting은 **분류** 에서 사용하며 Averaging은 **회귀** 에서 사용합니다.
(categorical인 경우에는 voting, numerical인 경우에는 averaging이기도 합니다.)

단어 그대로 투표, 평균의 방식으로 진행이 됩니다.
좀 더 구체적으로 서술하면 다음과 같은 과정으로 진행이 됩니다.

1. 일정 수의 base model과 predict를 만듭니다.
    - 1-1. 훈련 데이터를 나누어 같은 알고리즘을 사용하거나
    - 1-2. 훈련 데이터는 같지만 다른 알고리즘을 사용하거나
    - 1-3. 등등의 방법을 사용합니다.
2. 여기서 여러가지 방법으로 voting을 진행합니다.

base model은 Linear Regression, KNN, SVM 등 여러 머신러닝 모델을 사용하면 됩니다.
Voting과 Averaging은 다음과 같은 분류로 나눌 수 있습니다.

### 2-1. Majority Voting (Hard Voting)

각 모델은 test 데이터셋(또는 인스턴스)의 결과를 예측합니다. 그리고 예측값들의 다수결로 예측값을 정합니다.
이진 분류에 있어서는 과반수 이상이 선택한 예측값을 최종 예측으로 선택하는 것입니다.

이런 다수결의 성격때문에 max voting, plurality voting 라고도 부릅니다.


## 6. Conclusion


## Reference


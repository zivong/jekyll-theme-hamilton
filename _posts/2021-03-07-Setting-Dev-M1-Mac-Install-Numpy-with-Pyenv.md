---
layout: post
toc: true
title: "M1 Mac python 환경 구성하기 - numpy"
categories: Mac-setting
sitemap :
changefreq : daily
priority : 1.0
---

지난 포스트 [M1 Mac 세팅하기 - Homebrew, pyenv, numpy]({% post_url 2021-03-04-Setting-M1-Mac %})에서 기본적인 Mac 세팅방법을 알아보았습니다. 

이번 포스트에서는 pyenv에 `numpy`등 python package 설치방법을 정리했습니다. 

주먹구구 해결법으로 더 좋은 방법을 찾는다면 이후 수정해서 업로드 예정입니다.

## pyenv 설치하기

이전 포스트 참고 부탁드립니다. [M1 Mac 세팅하기 - Homebrew, pyenv, numpy]({% post_url 2021-03-04-Setting-M1-Mac %})

## Numpy & Pandas 등 python package 설치하기

### 오류내용
pyenv로 만든 환경 내에서 Numpy를 설치하고 실행하면 계속 오류가 발생했다.

```python
>>> import numpy as np
Traceback (most recent call last):
...
IMPORTANT: PLEASE READ THIS FOR ADVICE ON HOW TO SOLVE THIS ISSUE!

Importing the numpy C-extensions failed. This error can happen for
many reasons, often due to issues with your setup or how NumPy was
installed.

We have compiled some common reasons and troubleshooting tips at:

    https://numpy.org/devdocs/user/troubleshooting-importerror.html

Please note and check the following:

  * The Python version is: Python3.8 from "/Users/m/.pyenv/versions/env/bin/python"
  * The NumPy version is: "1.20.1"

and make sure that they are the versions you expect.
Please carefully study the documentation linked above for further help.
```

### miniconda를 이용한 numpy 설치하기

1. pyenv로 miniconda 설치합니다.

    ```
    pyenv install miniforge3-4.9.2
    ```

2. miniconda 기반으로 `conda-env` 환경을 만듭니다. (`conda-env` 대신 원하는 환경명을 작성합니다.) 
    
    이때 python 버전은 3.9.2 입니다. 

    ```
    pyenv virtualenv miniforge3-4.9.2 conda-env
    ```

3. `conda-env` 환경을 실행합니다. 

    miniconda 환경을 먼저 실행하고, miniconda 내에서 conda-env 환경을 추가로 실행합니다.

    ```
    pyenv activate miniforge3-4.9.2
    conda activate conda-env
    ```

4. 이제 conda를 이용한 python package 설치가 가능합니다.

    ```
    $ conda install numpy
    $ conda install pandas
    $ python
    ```
    ```python
    >>> import numpy as np
    >>> import pandas as pd
    ```

(M1 Mac으로 개발환경을 구성하는데 아직 어려움이 많이 있습니다. 저는 현재 서브 컴퓨터로 M1 Mac Mini를 사용 중 입니다. 구매 전 구글링으로 웬만한 것은 M1으로 가능하다는 것을 보고 구매 결정했습니다. 하지만 아직 가능하지만 쉽지 않은 환경인 것 같습니다. 메인 개발 환경을 M1 Mac으로 사용하는 것을 조금 더 고려해보시기 바랍니다.)
---
layout: post
toc: true
title: "M1 Mac 셋팅하기 - Homebrew, pyenv"
categories: Mac-setting
sitemap :
changefreq : daily
priority : 1.0
---

M1 맥 셋팅하는 과정을 정리했습니다. 중간 중간 겪은 어려움과 해결법까지 정리했습니다.

## Homebrew 설치하기

참고 자료
* [1](https://whitepaek.tistory.com/3)
* [2](https://velog.io/@mordred/Apple-M1-Mac%EC%97%90%EC%84%9C-HomeBrew-%EC%84%A4%EC%B9%98)

### Intel

[Homebrew](https://brew.sh/index_ko) 접속해서 스크립트를 복사하고 터미널을 열어 실행한다.

```bash
# bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

제대로 설치되었는지 확인하면서, 업데이트를 한다.

```bash
# bash
brew update
```

### M1 

Intel 방법으로 설치하면 업데이트시 `brew`를 찾을 수 없다고 나온다.

```bash
zsh command not found brew
```

아래 방법을 이용해 설치할 수 있다.
```zsh
# We'll be installing Homebrew in the /opt directory.
cd /opt

# Create a directory for Homebrew. This requires root permissions.
sudo mkdir homebrew

# Make us the owner of the directory so that we no longer require root permissions.
sudo chown -R $(whoami) /opt/homebrew

# Download and unzip Homebrew. This command can be found at https://docs.brew.sh/Installation.
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

# Add the Homebrew bin directory to the PATH. If you don't use zsh, you'll need to do this yourself.
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

터미널을 재실행하거나, 쉘 설정을 업데이트한다.

```bash
source ~/.zshrc
```

제대로 설치되었는지 확인하면서, 업데이트를 한다.

```bash
# bash
brew update
```

## 응용프로그램 설치하기

Homebrew를 이용해서 응용프로그램을 설치할 수 있다.

우선 `cask`라는 것을 설치한다.

```zsh
brew install cask
```

Iterm2, Slack, Chrome, VSCode, spectacle, keepingyouawake, karabiner-elements를 설치한다.

```zsh
brew install --cask iterm2 slack google-chrome visual-studio-code spectacle keepingyouawake karabiner-elements
```

### spectacle [맥에서 이중창 하기]

### keepingyouawake [맥 꺼짐 방지]

### karabiner-elements [커맨드로 한영 전환 하기]

[참고 자료](https://godoftyping.wordpress.com/2018/04/09/mac-%EB%A7%A5%EC%97%90%EC%84%9C-%ED%95%9C%EC%98%81%EC%A0%84%ED%99%98%ED%95%98%EB%8A%94-%EB%8B%A4%EC%96%91%ED%95%9C-%EB%B0%A9%EB%B2%95%EB%93%A4/)

## 그외 설치하기

### zsh

```zsh
brew install zsh
```

### zsh - oh-my-zsh

더 편리한 터미널을 만들어 준다 [참고 자료](https://medium.com/ayuth/iterm2-zsh-oh-my-zsh-the-most-power-full-of-terminal-on-macos-bdb2823fb04c)

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### pyenv

파이썬 버전 관리를 쉽게 한다. [참고 자료](http://guswnsxodlf.github.io/pyenv-virtualenv-autoenv)

```zsh
brew install pyenv pyenv-virtualenv xz
```

`~/.zshrc`를 연다.

```zsh
vim ~/.zshrc
```

아래 내용을 추가한다.
```
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

파이썬 3.8.6를 설치한다. 

```zsh
pyenv install 3.8.6
```

이런 오류가 나서 
<figure>
    <center>
        <img src="/assets/imgs/mac/pyenv-error.png" 
         width="90%" height="90%" alt=""/> 
        <figcaption>M1 pyenv error</figcaption>
    </center>
</figure>

```
➜  ~ pyenv install 3.8.4
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.8.4.tar.xz...
-> https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tar.xz
Installing Python-3.8.4...
python-build: use readline from homebrew
python-build: use zlib from xcode sdk

BUILD FAILED (OS X 11.1 using python-build 20180424)

Inspect or clean up the working tree at /var/folders/dq/w4l2nqb95vd3k4dgp04dnt600000gn/T/python-build.20210304220552.51334
Results logged to /var/folders/dq/w4l2nqb95vd3k4dgp04dnt600000gn/T/python-build.20210304220552.51334.log
```


아래로 해결했다(M1) [참고자료](https://github.com/pyenv/pyenv/issues/1768)
```
pyenv install --patch 3.8.6 <<(curl -sSL https://raw.githubusercontent.com/Homebrew/formula-patches/113aa84/python/3.8.3.patch\?full_index\=1)
```

설치한 버전을 바탕으로 환경을 만든다.
```zsh
pyenv virtualenv 3.8.6 env
```

### git

```zsh
brew install git
```

config 설정한다.

```zsh
git config --global user.name "LEEMINJOO"
git config --global user.email "leeminjoo@example.com"
```

### git - two-factor 설정

[참고 자료](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

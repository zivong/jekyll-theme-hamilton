---
layout: post
toc: true
title: "깃허브 블로그 셋업"
categories: 미분류
tags: [markdown, css, html]
author:
  - 닭
  - 찐따
---
# gh-pages 브랜치 만들기
---
---
```bash
# 한줄마다 코드치고 실행!

git branch gh-pages # 생성 
git checkout gh-pages # 이동

페이지 만들려고 하는 파일(html, css, js) 이동시키기
시작페이지는 index.html로 구성 

# 푸시하기 
git add . 
git commit -m '깃헙브랜치 반영'
git push origin gh-pages 
# 혹시 아래와 같은 에러가 뜬다면?
#! [rejected] gh-pages -> gh-pages (fetch first) 
# error: failed to push some refs to

git pull origin master
# 한번 당겨준 후 다시 
git push origin gh-pages
```
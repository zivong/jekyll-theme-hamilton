---
layout: page
title: 삽질
permalink: /about/
feature-img: "assets/img/pexels/travel.jpeg"
tags: [Page]
---

Type on Strap is based on Type Theme, a free and open-source theme for [Jekyll](http://jekyllrb.com/), licensed under the MIT License.

# width 조절
/_sass/hamilton/variables.scss

# [설치 오류](https://synoti21.github.io/blog%20dev/There-are-no-gemspecs-at-~~-%ED%95%B4%EA%B2%B0-%EB%B0%A9%EB%B2%95-(%EA%B9%83%ED%97%99-%ED%8E%98%EC%9D%B4%EC%A7%80-%EA%B2%8C%EC%8B%9C%ED%95%A0-%EB%95%8C)/)

# 로컬 설치
bundle install
bundle exec jekyll serve

```bash
bundle exec jekyll serve

─[:)] % git push            
To https://github.com/nodo1014/nodo1014.github.io.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/nodo1014/nodo1014.github.io.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

origin을 다시 뗑겨와서 gh-pages 로 ( 기본은 master나 main)
% git pull --rebase origin gh-pages
이후,
git add .
git commit -m "브랜치 정하기"
git push               
```
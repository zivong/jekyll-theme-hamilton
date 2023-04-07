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

jekyll을 로컬에 설치하려고 합니다Permalink
제 블로그는 2018년 봄에 만들었습니다. 그 당시에는 저의 첫 맥북인 2015년형 맥북에어를 사용하고 있었고, 해당 맥북에 jekyll을 설치하고 샥샥샥 해서 첫 블로그를 만들었죠. 현재는 2020년형 맥북에어를 사용하고 있습니다. 블로그 자료는 모두 깃헙에 올라와 있기 때문에, 깃헙에서 clone을 사용해서 제 블로그의 최신 repo를 가져오고, 나서 그냥 글을 쓴 다음, push를 해줬습니다. 따라서, local에 jekyll이 설치되어 있지 않아도 깃헙에 글을 써서 올리는 것 자체에는 아무 문제가 없죠.
그러나, 로컬에 jekyll이 설치되어 있지 않다면, 블로그에 새로운 테마 혹은 플러그인이 적용했을 때 어떻게 변화하는지 바로 확인하는 것이 어렵습니다. 바로 github에 올리고 그 다음에야 어떻게 변하는지 알게 되는데, 그 사이에는 시차가 존재하거든요. 따라서, 만약 블로그에 뭔가를 적용하고 싶다면, jekyll을 설치해서 변화를 파악하면서 처리해야 하죠.
저는 블로그에 mermaid-js를 적용하려고 합니다. WYMIWYG의 방식으로 마크다운 문서에 직접 그림을 넣는 방식을 말하죠. 이걸 적용하려면, jekyll을 설치해야 되더군요.
Install rubyPermalink
jekyll은 Ruby로 만들어진 정적 사이트 생성기(Static Site Generator)이며, Ruby의 패키지 매니저인 Gem을 사용해서 설치할 수 있습니다.
저의 경우 현재 ruby는 설치되어 있는 상황입니다.
$ ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin19]
Install Jekyll: ErrorPermalink
이제 jekyll을 설치해보겠습니다. gem install bundler jekyll을 사용해서 설치해 보는데… Gem::FilePermissionError가 발생하는군요.
$ gem install bundler jekyll
ERROR:  While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory.
Solve Gem::FilePermissionErrorPermalink
보통 이런 경우에는 그냥 sudo를 사용해서 설치하면 해결이 되곤 하는데, 그래도 되지 않습니다.
Gem::FilePermissionError는 보통 XCode 업데이트 후 커맨드라인 개발도구를 설치하지 않았기 때문에 발생한다고 합니다.
따라서, xcode-select --install를 실행하는데…그래도 되지 않네요. 일단 소프트웨어부터 다시 업데이트하라는 말이네요 흠..
$ xcode-select --install
xcode-select: error: command line tools are already installed, use "Software Update" to install updates
rbenv를 사용한 문제 해결Permalink
rbenv를 사용해서 처리하면 된다는 이야기가 있어서 다음 커맨드를 순서대로 실행해 봤습니다.
brew update
brew install rbenv ruby-build
그러나 2번 커맨드를 실행할 때 문제가 발생합니다. 저에게 해당 디렉토리를 변경할 권한이 없다는 이야기죠.
$ brew update
Updated 2 taps (homebrew/core and homebrew/cask).

$ brew install rbenv ruby-build
Updating Homebrew...
Error: The following directories are not writable by your user:
/usr/local/lib/pkgconfig
/usr/local/share/info
/usr/local/share/man/man3
/usr/local/share/man/man5

You should change the ownership of these directories to your user.
  sudo chown -R $(whoami) /usr/local/lib/pkgconfig /usr/local/share/info /usr/local/share/man/man3 /usr/local/share/man/man5

And make sure that your user has write permission.
  chmod u+w /usr/local/lib/pkgconfig /usr/local/share/info /usr/local/share/man/man3 /usr/local/share/man/man5
따라서, 현재 유저인 저에게 권한을 부여합니다.
그리고, brew install rbenv ruby-build를 다시 실행해주면 잘 진행되는 것을 알 수 있죠.
$ sudo chown -R $(whoami) /usr/local/lib/pkgconfig /usr/local/share/info /usr/local/share/man/man3 /usr/local/share/man/man5
...
$ brew install rbenv ruby-build
... 
$ rbenv -v 
rbenv 1.1.2
이제 rbenv를 사용해서, ruby 가상환경을 설치하려 합니다.
그리고, 최신 버전인 3.0.0을 설치하기로 해줍니다.
$ rbenv install -l
2.5.8
2.6.6
2.7.2
3.0.0
jruby-9.2.14.0
mruby-2.1.2
rbx-5.0
truffleruby-20.3.0
truffleruby+graalvm-20.3.0

$ rbenv install 3.0.0 
...
Installed ruby-3.0.0 to /Users/seunghoonlee/.rbenv/versions/3.0.0
그다음 rbenv versions를 통해 현재 설치된 버전을 확인해보면, 두 버전이 존재하는 것을 알 수 있습니다.
$ rbenv versions
* system (set by /Users/seunghoonlee/.rbenv/version)
  3.0.0
3.0.0 버전을 global로 변경해줍니다.
$ rbenv global 3.0.0
$ rbenv versions    
  system
* 3.0.0 (set by /Users/seunghoonlee/.rbenv/version)
그 다음, ~/.zshrc에 아래 내용을 추가해줍니다. rbenv를 활성화해준다는 이야기죠.
저는 zsh를 사용하기 때문에, 위 경로에 추가했지만, 만약, bash를 사용한다면 .bashrc에 내용을 작성해줘야 합니다.
# 20210119 ADD 
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"
그리고 source ~/.zshrc를 사용합니다(아니면, 터미널을 껐다가 켜도 됩니다).
그 다음 ruby의 버전을 확인해보면 설치한 버전으로 변경된 것을 알 수 있죠.
$ source ~/.zshrc
$ ruby -v   
ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-darwin19]
이제 다시 gem install bundler를 실행하면 잘 설치되는 것을 알 수 있습니다.
$ gem install bundler
Fetching bundler-2.2.5.gem
Successfully installed bundler-2.2.5
Parsing documentation for bundler-2.2.5
Installing ri documentation for bundler-2.2.5
Done installing documentation for bundler after 3 seconds
1 gem installed
그리고 다시 gem install jekyll를 실행합니다. 그럼 설치가 잘 되는데,
gem install jekyll
그리고 jekyll serve를 실행해봤지만, Bundler::GemNotFound와 함께 더 진행이 되지 않습니다.
$ jekyll serve            
/Users/seunghoonlee/.rbenv/versions/3.0.0/lib/ruby/gems/3.0.0/gems/bundler-2.2.5/lib/bundler/resolver.rb:314:in `block in verify_gemfile_dependencies_are_found!': Could not find gem 'jekyll (~> 3.5)' in any of the gem sources listed in your Gemfile. (Bundler::GemNotFound)
bundle은 일종의 package manager입니다. 간단하게는 Gemfile에 등록되어 있는 Gem에 맞춰서 패키지를 사용해 의존성을 해결하겠다는 이야기죠.
즉, bundle exec를 사용한다면 Gemfile에 따라 jekyll을 실행하게 되죠.
bundle exec jekyll server를 실행해보니, Gemfile에 jekyll에 대한 버전이 등록되어 있지 않다는 메세지가 나옵니다.
$ bundle exec jekyll serve
Could not find gem 'jekyll (~> 3.5)' in any of the gem sources listed in your Gemfile.
Run `bundle install` to install missing gems.
이번에는 bundle install을 실행해봅니다. 의존성을 해결하기 위해서 다른 gem들이 설치되었습니다.
$ bundle install
Fetching gem metadata from https://rubygems.org/..........
Fetching gem metadata from https://rubygems.org/.
Resolving dependencies...
Using ...
Bundle complete! 2 Gemfile dependencies, 38 gems now installed.
다시 jekyll serve를 실행해 봅니다.
오류를 잘 보면, 현재 제 로컬에서 활성화되어 있는 버전은 i18n 1.8.7인데, 저의 Gemfile에는 i18n 0.9.5가 설치되어 있다는 말이죠. 이걸 다 뜯어고치기는 어려우니까, 그냥 bundle exec를 앞에 붙여서 사용하면 될 거라, 라는 정도의 이야기를 하는 거죠.
$ jekyll serve
/Users/seunghoonlee/.rbenv/versions/3.0.0/lib/ruby/gems/3.0.0/gems/bundler-2.2.5/lib/bundler/runtime.rb:302:in `check_for_activated_spec!': You have already activated i18n 1.8.7, but your Gemfile requires i18n 0.9.5. Prepending `bundle exec` to your command may solve this. (Gem::LoadError)
...
bundle exec jekyll serve를 사용해봅니다.
잘되는 것 같다가…이번에는 다음과 같은 오류가 뜨네요.
 Dependency Error: Yikes! It looks like you don't have kramdown-parser-gfm or one of its dependencies installed. In order to use Jekyll as currently configured, you'll need to install this gem. The full error message from Ruby is: 'cannot load such file -- kramdown-parser-gfm' If you run into trouble, you can find helpful resources at https://jekyllrb.com/help/! 
  Conversion error: Jekyll::Converters::Markdown encountered an error while converting '_posts/9_PROJECT/2017-06-05-making_meal_alarming_bot.md':
                    kramdown-parser-gfm
             ERROR: YOUR SITE COULD NOT BE BUILT:
                    ------------------------------------
                    kramdown-parser-gfm
현재 bundle로 실행하는데, kramdown-parser-gfm이 없다는 말이므로 Gemfile에 아래 내용을 작성(및 추가) 해줍니다.
source "https://rubygems.org"

gem "jekyll", "~> 3.5"
gem "minimal-mistakes-jekyll"
gem "kramdown-parser-gfm"
그 다음 bundle install을 통해 Gemfile에 작성된 Gem을 모두 설치해줍니다.
bundle install
그 다음 bundle exec jekyll serve --incremental를 실행하면, 에러가 없는 것처럼 보이기는 하는데 너무 일단 약 6분이 걸려서 되다가, 일단 오류가 발생합니다.
오류를 자세히 보면, webrick을 로드하는데 문제라는 것같네요.
$ bundle exec jekyll serve
Configuration file: /Users/seunghoonlee/frhyme.github.io/_config.yml
            Source: /Users/seunghoonlee/frhyme.github.io
       Destination: /Users/seunghoonlee/frhyme.github.io/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
       Jekyll Feed: Generating feed for posts
                    done in 337.821 seconds.
 Auto-regeneration: enabled for '/Users/seunghoonlee/frhyme.github.io'
bundler: failed to load command: jekyll (/Users/seunghoonlee/.rbenv/versions/3.0.0/bin/jekyll)
/Users/seunghoonlee/.rbenv/versions/3.0.0/lib/ruby/gems/3.0.0/gems/jekyll-3.9.0/lib/jekyll/commands/serve/servlet.rb:3:in `require': cannot load such file -- webrick (LoadError)
...
이번에는 webrick을 추가해줍니다. 아래 커맨드를 실행하면 됩니다.
실행한 다음 Gemfile을 확인해보면, gem "webrick", "~> 1.7"이 추가되어 있는 것을 알 수 있죠.
bundle add webrick
그리고 다시 서버를 띄우고, localhost:4000으로 접속해보면 잘 되는 것을 알 수 있습니다.
$ bundle exec jekyll serve --incremental
Configuration file: /Users/seunghoonlee/frhyme.github.io/_config.yml
            Source: /Users/seunghoonlee/frhyme.github.io
       Destination: /Users/seunghoonlee/frhyme.github.io/_site
 Incremental build: enabled
      Generating... 
       Jekyll Feed: Generating feed for posts
                    done in 361.071 seconds.
 Auto-regeneration: enabled for '/Users/seunghoonlee/frhyme.github.io'
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
Wrap-upPermalink
후, 결과적으로는 잘 해결했으니 다행입니다만, 아주 힘들었습니다 어이고.
오늘 배운 내용을 정리하면 대략 다음과 같습니다.
Jekyll은 Ruby로 개발되었으며 따라서 설치하기 위해서는 Gem을 사용해야 함.
Jekyll의 package manager는 bundle. bundle에 대한 의존성은 Gemfile에 정리되어 있습니다. 따라서, 이 bundle이 어떤 라이브러리에 의존하는지를 확인하고 싶다면, Gemfile을 참고하면 됩니다.
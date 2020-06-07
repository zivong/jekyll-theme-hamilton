# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-hamilton"
  spec.version       = "1.2.0"
  spec.authors       = ["Shangzhi Huang"]
  spec.email         = ["ngzhio@gmail.com"]

  spec.summary       = "Another minimal style of Jekyll theme for writers"
  spec.homepage      = "https://github.com/ngzhio/jekyll-theme-hamilton"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.0"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.6.1"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.13.0"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.4.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
end

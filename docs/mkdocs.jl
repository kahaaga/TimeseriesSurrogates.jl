site_name:           TimeseriesSurrogates.jl
repo_url:            https://github.com/kahaaga/TimeseriesSurrogates
site_description:    "Documentation"
site_author:         kahaaga
theme:               readthedocs

extra_css:
  - assets/Documenter.css

extra_javascript:
  - https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS_HTML
  - assets/mathjaxhelper.js

markdown_extensions:
  - extra
  - tables
  - fenced_code
  - mdx_math

docs_dir: 'build'

pages:
  - Home: index.md

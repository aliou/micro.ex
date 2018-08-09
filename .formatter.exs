custom_locals_without_parens = [
  redirect: 2
]

[
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{ex,exs}"
  ],
  locals_without_parens: custom_locals_without_parens,
  import_deps: [:ecto, :plug]
]

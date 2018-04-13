custom_locals_without_parens = [
  redirect: 2
]

[
  inputs: [
    "lib/**/*.{ex,exs}"
  ],
  line_length: 80,
  locals_without_parens: custom_locals_without_parens,
  import_deps: [:ecto, :plug]
]

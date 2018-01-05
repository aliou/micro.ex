# TODO: Remove this when plug exports this list.
plug_locals_without_parens = [
  plug: 1,
  plug: 2,
  forward: 2,
  forward: 3,
  forward: 4,
  match: 2
]

ecto_locals_without_parens = [
  from: 2,
  field: 2
]

custom_locals_without_parens = [
  redirect: 2
]

[
  inputs: [
    "lib/**/*.{ex,exs}"
  ],
  line_length: 80,
  locals_without_parens:
    plug_locals_without_parens ++
      ecto_locals_without_parens ++ custom_locals_without_parens
  # import_deps: [:plug],
]

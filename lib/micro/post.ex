defmodule Micro.Post do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :content, :string
    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> Ecto.Changeset.cast(params, [:content])
    |> Ecto.Changeset.validate_required([:content])
  end
end

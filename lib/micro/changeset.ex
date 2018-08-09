defmodule Micro.Changeset do
  import Ecto.Changeset

  @spec nullable_unique_constraint(Ecto.Changeset.t(), atom, Keyword.t()) :: Ecto.Changeset.t()
  def nullable_unique_constraint(%Ecto.Changeset{} = changeset, field, opts \\ []) do
    # TODO: Handle unique lol
    unique_constraint(changeset, field, opts)
  end
end

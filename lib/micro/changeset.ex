defmodule Micro.Changeset do
  import Ecto.Changeset

  # NOTE: There's a good chance that this is useless and that null values are ignored for unique
  # constraints. Need to check both Ecto and Postgres to see if this is the case.
  @doc """
  Checks for a unique constraint in the given field if the field is not null.

  See documentation for `Ecto.Changeset.unique_constraint/3`
  """
  @spec nullable_unique_constraint(Ecto.Changeset.t(), atom, Keyword.t()) :: Ecto.Changeset.t()
  def nullable_unique_constraint(
        %Ecto.Changeset{params: params, changes: changes} = changeset,
        field,
        opts \\ []
      ) do
    new_value = changes[field] || params[to_string(field)]
    nullable_unique_constraint(changeset, field, opts, new_value)
  end

  defp nullable_unique_constraint(changeset, field, opts, field_value)

  defp nullable_unique_constraint(changeset, _field, _opts, nil), do: changeset

  defp nullable_unique_constraint(changeset, field, opts, _value),
    do: unique_constraint(changeset, field, opts)
end

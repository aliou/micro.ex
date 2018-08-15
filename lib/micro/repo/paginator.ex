defmodule Micro.Repo.Paginator do
  import Ecto.Query

  defmodule Pagination do
    defstruct per_page: 30, page: 1

    @type t :: %__MODULE__{
            per_page: integer(),
            page: integer()
          }
  end

  defmodule InvalidPagination do
    defexception [:message]

    def exception(value) do
      %InvalidPagination{message: "Invalid pagination, got: #{inspect(value)}"}
    end
  end

  # TODO: Make this less naive? Investigate cursor and other stuff.
  # See: <https://aliou.wtf/l/KPpbb>
  @doc """
  Paginate an Ecto query
  """
  @spec paginate(Ecto.Query.t(), Pagination.t()) :: Ecto.Query.t() | :no_return
  def paginate(query, %Pagination{page: page, per_page: per_page})
      when page >= 1 and per_page >= 1 do
    offset = (page - 1) * per_page
    from p in query, limit: ^per_page, offset: ^offset
  end

  def paginate(_, pagination), do: raise(InvalidPagination, pagination)
end

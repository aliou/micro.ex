defmodule Micro.Repo.PaginatorTest do
  import Ecto.Query, only: [from: 1]
  alias Micro.Repo.Paginator
  use ExUnit.Case, async: true

  defmodule TestSchema do
    use Ecto.Schema

    schema "test" do
    end
  end

  describe "paginate/3" do
    test "it raises an error when passing an invalid page number" do
      query = from(p in TestSchema)
      pagination = %Paginator.Pagination{page: -1, per_page: 1}

      assert_raise Paginator.InvalidPagination, fn ->
        Paginator.paginate(query, pagination)
      end
    end

    test "it raises an error when passing an invalid per_page number" do
      query = from(p in TestSchema)
      pagination = %Paginator.Pagination{page: 1, per_page: -1}

      assert_raise Paginator.InvalidPagination, fn ->
        Paginator.paginate(query, pagination)
      end
    end
  end
end

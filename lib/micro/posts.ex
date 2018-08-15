defmodule Micro.Posts do
  alias Micro.{Post, Repo, Repo.Paginator}
  import Ecto.Query, only: [from: 1, from: 2]

  # this might be refactorable with `with` ?
  @spec friendly_find(String.t(), Ecto.Query.t() | Post) :: {:ok, Post.t()} | :not_found
  def friendly_find(id_or_slug, query \\ Post) do
    query =
      case Ecto.UUID.cast(id_or_slug) do
        {:ok, uuid} -> from post in query, where: [id: ^uuid]
        _ -> from post in query, where: [slug: ^id_or_slug]
      end

    case Repo.one(query) do
      nil -> :not_found
      post -> {:ok, post}
    end
  end

  @doc """
  Return a paginated list of posts.
  """
  # TODO: Return the pagination metadata (current_page, total_pages, total_count, per_page)
  @spec paginated_posts(integer(), integer(), Ecto.Query.t() | Post) :: [Post]
  def paginated_posts(page, per_page \\ 10, query \\ Post)

  # Transform the last argument into an `Ecto.Query`
  def paginated_posts(page, per_page, Post = query) do
    query = from(p in query)
    paginated_posts(page, per_page, query)
  end

  # If we don't have an ordering defined, order the query by insertion date.
  def paginated_posts(page, per_page, %Ecto.Query{order_bys: []} = query) do
    query = from p in query, order_by: [desc: :inserted_at]
    paginated_posts(page, per_page, query)
  end

  def paginated_posts(page, per_page, %Ecto.Query{} = query) do
    pagination = %Paginator.Pagination{page: page, per_page: per_page}
    query |> Paginator.paginate(pagination) |> Repo.all()
  end
end

defmodule Micro.Posts do
  alias Micro.{Post, Repo}
  import Ecto.Query, only: [from: 2]

  # this might be refactorable with `with` ?
  @spec friendly_find(String.t(), Ecto.Query.t()) :: Post.t()
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
end

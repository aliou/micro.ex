defmodule Micro.Template do
  @moduledoc """
  This whole module is trash. /shrug
  """
  require EEx

  @template_path "lib/micro/templates/"

  defmodule UnknownTemplate do
    defexception [:message]

    def exception(value) do
      %__MODULE__{message: "Invalid template, got: #{inspect(value)}"}
    end
  end

  @doc "Renders a partial inside the main layout"
  @spec render(String.t(), any()) :: String.t()
  def render(template_name, vars) do
    render_layout([view_template: template_name], assigns: vars)
  end

  # Partials: Delegate to template functions by passing the arguments.
  defp render_partial("posts", assigns: [posts: posts, pagination: pagination]),
    do: render_posts(posts: posts, pagination: pagination)

  defp render_partial("post", assigns: post), do: render_post(post: post)
  defp render_partial(template, _), do: raise(UnknownTemplate, template)

  # Actual EEx templates, generated as functions at compile time.
  EEx.function_from_file(:defp, :render_post, @template_path <> "post.eex", [:assigns])
  EEx.function_from_file(:defp, :render_posts, @template_path <> "posts.eex", [:assigns])

  EEx.function_from_file(:defp, :render_layout, @template_path <> "layout.eex", [
    :assigns,
    :partial_assigns
  ])
end

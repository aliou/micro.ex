defmodule Micro.Router.Utils do
  import Plug.Conn, only: [put_resp_content_type: 2, send_resp: 3]

  defmacro redirect(path, options) when is_binary(path) do
    quote bind_quoted: [path: path, options: options] do
      {target, options} = Keyword.pop(options, :to)

      if is_nil(target) do
        raise ArgumentError, message: "expected :to to be given as option"
      end

      @plug_redirect_target target
      match path do
        var!(conn)
        |> Plug.Conn.put_resp_header("location", @plug_redirect_target)
        |> Plug.Conn.resp(301, "You are being redirected.")
        |> Plug.Conn.halt()
      end
    end
  end

  def resp_html(conn, content, status \\ 200) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(status, content)
  end

  def not_found(conn, message \\ "not found") do
    send_resp(conn, 404, message)
  end
end

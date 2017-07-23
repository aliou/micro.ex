defmodule Feed.RFC3339Test do
  use ExUnit.Case, async: true

  test "" do
    %{
      "1970-01-01T00:00:00.000000+00:00" => DateTime.from_unix!(0),

      "2017-07-01T06:10:51.615836+00:00" =>
        ~N[2017-07-01 06:10:51.615836] |> DateTime.from_naive!("Etc/UTC"),

      "2017-04-25T22:15:00.000000+00:00" =>
        ~N[2017-04-25 22:15:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-04-28T14:39:00.000000+00:00" =>
        ~N[2017-04-28 14:39:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-19T21:18:00.000000+00:00" =>
        ~N[2017-06-19 21:18:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-22T16:03:00.000000+00:00" =>
        ~N[2017-06-22 16:03:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-25T21:40:00.000000+00:00" =>
        ~N[2017-06-25 21:40:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-26T22:13:00.000000+00:00" =>
        ~N[2017-06-26 22:13:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-28T07:21:00.000000+00:00" =>
        ~N[2017-06-28 07:21:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-28T23:04:00.000000+00:00" =>
        ~N[2017-06-28 23:04:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-06-30T23:26:00.000000+00:00" =>
        ~N[2017-06-30 23:26:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      "2017-07-01T01:16:00.000000+00:00" =>
        ~N[2017-07-01 01:16:00.000000] |> DateTime.from_naive!("Etc/UTC"),

      # "2017-07-01T05:51:47.311274+00:00" =>
      #   ~N[2017-07-01 05:51:47.311274] |> DateTime.from_naive!("Etc/UTC"),

      # "2017-07-01T06:10:51.615836+00:00" =>
      #   ~N[2017-07-01 06:10:51.615836] |> DateTime.from_naive!("Etc/UTC"),

    } |> Enum.each(fn({expected, to_format}) ->
      assert expected == Feed.RFC3339.format!(to_format)
    end)
  end
end

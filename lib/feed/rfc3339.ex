defmodule Feed.RFC3339 do
  @moduledoc """
  Simple RFC3339 Date formatter.
  """

  @spec format!(DateTime.t) :: String.t
  def format!(datetime) do
    case format(datetime) do
      {:ok, formatted} -> formatted
      {:error, _} -> raise "Error formatting the date"
    end
  end

  @spec format(DateTime.t) :: String.t
  def format(
    %DateTime{
      year: year, month: month, day: day, hour: hour, minute: minute,
      second: second, microsecond: microsecond, utc_offset: utc_offset
    }
  ) do
    month = month |> Integer.to_string() |> pad()
    day = day |> Integer.to_string() |> pad()
    hour = hour |> Integer.to_string() |> pad()
    minute = minute |> Integer.to_string() |> pad()
    second = second |> pad()
    {ms, _} = microsecond
    ms = ms |> pad(6)
    offset = second_to_hours(utc_offset)
    {:ok, "#{year}-#{month}-#{day}T#{hour}:#{minute}:#{second}.#{ms}+#{offset}"}
  end

  defp pad(d, length \\ 2)

  defp pad(d, length) when is_number(d), do: d |> Integer.to_string() |> pad(length)
  defp pad(digit, length), do: String.pad_leading(digit, length, "0")

  defp second_to_hours(seconds) do
    hours = Integer.floor_div(seconds, 3600)
    minutes = Integer.floor_div(seconds - (hours * 3600), 60)

    pad(hours) <> ":" <> pad(minutes)
  end
end

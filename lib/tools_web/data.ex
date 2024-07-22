defmodule ToolsWeb.Data do
  @moduledoc """
  Loads tool data from a JSON file during application startup and provides access functions.
  """

  @json_file_path "priv/static/tools.json"

  def load_json(path) do
    case File.read(path) do
      {:ok, json_content} ->
        case Jason.decode(json_content) do
          {:ok, json} when is_list(json) ->
            parse_entries(json)

          {:error, reason} ->
            IO.puts("Failed to parse JSON: #{reason}")
        end

      {:error, reason} ->
        IO.puts("Failed to read #{path}: #{reason}")
    end
  end

  defp parse_entries(entries) do
    Enum.map(entries, &parse_entry/1)
  end

  defp parse_entry(%{"title" => title, "tag" => tag, "redirected_url" => redirected_url}) do
    %{title: title, tag: tag, redirected_url: redirected_url}
  end

  defp parse_entry(_) do
    %{}
  end

  def get_tool_list do
    load_json(@json_file_path)
  end

  def check(name) do
    tools_local = get_tool_list()
    IO.puts("name of the tool #{name}")
    Enum.find(tools_local, fn content -> content.title == name end) || nil
  end
end

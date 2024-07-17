defmodule ToolsWeb.ToolsController do
  use ToolsWeb, :controller

  # each controller has to take a conn and a params.
  # conn - holds the request data
  # params: request params.
  def index(conn, _params) do
    # this expects a view which is named after the controller to exist.
    # Name will be ToolsHTMl and :index means that the template file which will be rendered is index.

    # pass the layout parameter to determine it should inherit the parameter or not.
    render(conn, :index, layout: false)
  end

  def tools(conn, _param) do
    render(conn, :tools_listing, layout: false)
  end

  def tool_details(conn, %{"id" => id}) do
    # pass the id of tool from param
    render(conn, :tool_details, id: id, layout: false)
  end

  def raw_entry(conn, %{"id" => id}) do
    # pass the id of tool from param
    json(conn, %{id: id})
  end
end

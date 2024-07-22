defmodule ToolsWeb.ToolsController do
  # brings in functions to define controllers
  use ToolsWeb, :controller

  # each controller has to take a conn and a params.
  # conn - holds the request data
  # params: request params.

  # dataset

  def index(conn, _params) do
    # this expects a view which is named after the controller to exist.
    # Name will be ToolsHTMl and :index means that the template file which will be rendered is index.

    # pass the layout parameter to determine it should inherit the parameter or not.
    render(conn, :index, layout: false)
  end

  def tools(conn, _param) do
    # for now, render a page with list of 10 tools
    list = ToolsWeb.Data.get_tool_list()

    render(conn, :tools_listing, tools: list, layout: false)
  end

  def tool_details(conn, %{"name" => name}) do
    tool = ToolsWeb.Data.check(name)

    if tool do
      render(conn, :tool_details, item: tool, layout: false)
    else
      render(conn, :not_found, item: name, layout: false)
    end
  end

  def raw_entry(conn, %{"id" => id}) do
    json(conn, %{id: id})
  end
end

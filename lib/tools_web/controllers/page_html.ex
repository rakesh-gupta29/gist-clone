# this holds the rendering formatter for the HTML pages.

# we can create similar ones for JSON. reger to page_json

defmodule ToolsWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use ToolsWeb, :html

  embed_templates "page_html/*"
end

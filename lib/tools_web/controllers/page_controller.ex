defmodule ToolsWeb.PageController do
  # under the hood, controllers are just plugs which can be enhanced to provide any feature/function inside of a function.

  use ToolsWeb, :controller

  # actions. they have to take some parametes and then conclude the request to be called a action/router action.
  # we can name/moodify them in the way we want as long as they follow the naming rules.

  # conn is connection data which holds the connection and
  # _params is the parameters of the request like which holds
  #  the payload for the request which is passed by the client.
  # we can add other parameters too in the request life cycle.
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    # instead of the render function, pheonix returns a lot of utility functions for multiple use cases. like sending a text, json or html.

    # we can change the layout to refer for the types of formats
    render(conn, :home, layout: false)
  end
end

# when rendering a view, the controller requires the HTML module to exist.

# like in here, when we call the render method in the home action inside of PageController, we invoke the PageHTML (important to follow this convention) which should use the :html macro and the directive to point to the folder where the template files lives.

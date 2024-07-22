defmodule ToolsWeb.Router do
  use ToolsWeb, :router

  pipeline :browser do
    # include the formats here that route should accept
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ToolsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ToolsWeb do
    pipe_through :browser

    # we use a macro for route definitions because at compile time, elixir will convert this to the if-else case statements
    # which will be optimised for runtime performance.

    # see how one controller can have one HTML renderer attached with it and can have  multiple options attached as per the controller.

    #  in here, pagecontroller calls the pagecontroller which goes to the pagehtml and renders the page_html templates.

    get "/", PageController, :home

    # this will be a separate controller and can have its owne ToolsHTMl and hierarchy of layouts and templates.
    get "/contact", ToolsController, :index
    get "/tools", ToolsController, :tools
    get "/tools/:name", ToolsController, :tool_details
    get "/tools/raw/:name", ToolsController, :raw_entry
  end

  # Other scopes may use custom stacks.
  # scope "/api", ToolsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:tools, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ToolsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

# there is a sigil ~p which will allow checks for route paths.
# we can write routes in our templates/tests and it will check that the routes are actually defined
# in the router modules.
# e.g. in a link tag in html or a redirect in the controller.

# for query params, we can provide a dict with allowed values.
# resources: it will define all the routes for the that module. like what happens in laravel
# resources "/users" UserController => will be creating a group of routes to provide CRUD over users.

# resources can be used for nested routes too.
# resources "/users", UserController do
#   resources "/posts", PostController
# end

# one handy tool is having mix phx.routes and it will provide all the list of routes available in the app.

# PIPELINE:
# define a series of plugs to run on a scoped routes.
# through a pipe_through macro.
# good examples are :browser and :api routes. may be cookies and tokens, what headers they accepts and what they return.

# we can define a series of scopes and pipelines to match the routes and run the plugs.
# for a good examples, visit https://hexdocs.pm/phoenix/routing.html#how-to-organize-my-routes

# FORWARD:
#  we can forward the routes to the tasks e.g. running a bacckground task for sending emails.

# can a forward/background task retain the context of the request. like if I use the forward to schedule a background task
# which will take an hour how can I preserve the context and then respond to that request.

# refer to this page to see different approaches in which we can render the page or conclude the response. https://hexdocs.pm/phoenix/controllers.html#rendering

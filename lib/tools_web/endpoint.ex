defmodule ToolsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :tools

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_tools_key",
    signing_salt: "DK4WjeJJ",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :tools,
    gzip: false,
    only: ToolsWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :tools
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # this defines the list of plugs that the request will go through to process the request.
  # finally giving the control to the router.

  # function based plug
  plug :print_req_details

  # module based plug
  plug ToolsWeb.Plugs.LogReq

  plug Plug.Session, @session_options
  plug ToolsWeb.Router

  def print_req_details(conn, _opts) do
    IO.puts("""
    From function based plug
    Verb: #{inspect(conn.method)}
    Host: #{inspect(conn.host)}
    """)

    conn
  end
end

# plugs can be defined at three places:
# application/endpoint: common for the app. runs on all requests
# router: for one router/group of routers i.e. within one router scope
# controller: we can compose the plugs within the controller too to manage some tasks.

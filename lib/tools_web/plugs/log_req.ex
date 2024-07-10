defmodule ToolsWeb.Plugs.LogReq do
  # we can define the plugs in two days
  # based on the function: should take  conn and opts as parameters and return conn map

  # for module based plugs, we have to define the init function which will initialise the args to be passed to second function.
  # which is call which will accept the conn and opts params, do the conn transformation and it has to return the conn

  # function plugs + init function = module plugs. (more or less)

  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    IO.puts("""
    From the module based plug:
    Verb: #{inspect(conn.method)}
    Host: #{inspect(conn.host)}
    """)

    # assign a variable which will be available in the local request context

    conn
  end
end

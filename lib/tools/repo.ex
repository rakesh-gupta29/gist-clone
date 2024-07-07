defmodule Tools.Repo do
  use Ecto.Repo,
    otp_app: :tools,
    adapter: Ecto.Adapters.Postgres
end

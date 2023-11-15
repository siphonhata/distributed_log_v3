defmodule DistributedLogV3.Repo do
  use Ecto.Repo,
    otp_app: :distributed_log_v3,
    adapter: Ecto.Adapters.Postgres
end

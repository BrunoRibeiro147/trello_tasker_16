defmodule TrelloTasker16.Repo do
  use Ecto.Repo,
    otp_app: :trello_tasker_1_6,
    adapter: Ecto.Adapters.Postgres
end

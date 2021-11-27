defmodule TrelloTasker16Web.PageController do
  use TrelloTasker16Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

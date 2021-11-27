defmodule TrelloTasker16Web.CardInfoLive do
  use TrelloTasker16Web, :live_view

  alias Phoenix.View
  alias TrelloTasker16Web.CardView
  alias TrelloTasker16.Shared.Services.GetCardInfo

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {card_comments, card_info} = GetCardInfo.execute(id)
    {:ok, socket |> assign(comments: card_comments, card: card_info)}
  end

  @impl true
  def render(assigns) do
    View.render(CardView, "info.html", assigns)
  end
end

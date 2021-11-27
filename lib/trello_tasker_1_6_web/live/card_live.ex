defmodule TrelloTasker16Web.CardLive do
  use TrelloTasker16Web, :live_view

  alias Phoenix.View
  alias TrelloTasker16.Cards.Card
  alias TrelloTasker16Web.CardView
  alias TrelloTasker16.Shared.Services.FindAllCards
  alias TrelloTasker16.Shared.Services.CreateCard

  @impl true
  def mount(_params, _session, socket) do
    changeset = Card.changeset(%Card{})

    cards = FindAllCards.execute()

    {:ok, socket |> assign(cards: cards, changeset: changeset)}
  end

  @impl true
  def handle_event("create", %{"card" => card}, socket) do
    changeset = %Ecto.Changeset{Card.changeset(%Card{}, card) | action: :insert}

    changeset.valid?
    |> case do
      false ->
        {:noreply, assign(socket, :changeset, changeset)}

      true ->
        card
        |> CreateCard.execute()
        |> response(socket)
    end
  end

  defp response({:trello_error, msg}, socket),
    do: {:noreply, socket |> put_flash(:error, msg) |> push_redirect(to: "/")}

  defp response({:ok, _card}, socket),
    do:
      {:noreply, socket |> put_flash(:info, "Card criado com sucesso") |> push_redirect(to: "/")}

  defp response({:error, changeset}, socket),
    do: {:noreply, assign(socket, :changeset, changeset)}

  @impl true
  def render(assigns) do
    View.render(CardView, "index.html", assigns)
  end
end

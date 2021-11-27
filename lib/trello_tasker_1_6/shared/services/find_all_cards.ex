defmodule TrelloTasker16.Shared.Services.FindAllCards do
  alias TrelloTasker16.Cards
  alias TrelloTasker16.Shared.Services.Trello
  alias TrelloTasker16.Shared.Providers.CacheProvider.CardCacheClient

  @table "card-list"

  def execute() do
    CardCacheClient.recover(@table)
    |> case do
      {:not_found, []} ->
        IO.inspect("sem cache")

        cards =
          Cards.list_cards()
          |> Enum.map(&Trello.get_card(&1.path))

        CardCacheClient.save(@table, cards)
        cards

      {:ok, cards} ->
        cards
    end
  end
end

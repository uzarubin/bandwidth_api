defmodule BandwidthApi.Endpoints.AvailableNumbers do

  alias BandwidthApi.Client

  @doc """

  """

  def search(type, params \\ %{}) # Function header
  def search(:local, params), do: Client.list_local_numbers(partial_url(:local), build_query_params(params))
  def search(:toll_free, params), do: Client.list_toll_free_numbers(partial_url(:tollFree), build_query_params(params))

  def order(type, params \\ %{})
  def order(:local, params), do: Client.order_local_number(partial_url(:local), build_query_params(params))
  def order(:toll_free, params), do: Client.order_toll_free_number(partial_url(:tollFree), build_query_params(params))


  def partial_url(:local), do: "availableNumbers/local"
  def partial_url(:tollFree), do: "availableNumbers/tollFree"

  defp build_query_params(params) do
    params |> Enum.map(&(&1))
  end
end
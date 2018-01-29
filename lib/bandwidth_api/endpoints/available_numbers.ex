defmodule BandwidthApi.Endpoints.AvailableNumbers do

  alias BandwidthApi.Client

  @doc """

  """

  def search(type, params \\ %{}) # Function header
  def search(:local, params), do: Client.list_local_numbers("availableNumbers/local", build_query_params(params))
  def search(:toll_free, params), do: Client.list_toll_free_numbers("availableNumbers/tollFree", build_query_params(params))

  def order(type, params \\ %{})
  def order(:local, params), do: Client.order_local_number("availableNumbers/local", build_query_params(params))
  def order(:toll_free, params), do: Client.order_toll_free_number("availableNumbers/tollFree", build_query_params(params))

  defp build_query_params(params) do
    params |> Enum.map(&(&1))
  end
end
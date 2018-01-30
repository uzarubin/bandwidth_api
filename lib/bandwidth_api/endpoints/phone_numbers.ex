defmodule BandwidthApi.Endpoints.PhoneNumbers do

  alias BandwidthApi.Client
  import BandwidthApi.Config, only: [user_id: 0]

  def search(params), do: Client.list_phone_numbers(partial_url(), params)
  def order(params), do: Client.order_phone_number(partial_url(), params)
  def info(params), do: Client.number_info(partial_url_with_id(params.number_id), params)

  def partial_url, do: "users/#{user_id()}/phoneNumbers"
  def partial_url_with_id(number_id), do: "/users/#{users_id}/phoneNumbers/#{number_id}"

end
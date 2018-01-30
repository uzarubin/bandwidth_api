defmodule BandwidthApi.Endpoints.PhoneNumbers do

  alias BandwidthApi.Client
  import BandwidthApi.Config, only: [user_id: 0]

  def search(params), do: Client.list_phone_numbers(partial_url(), params)
  def order(params), do: Client.order_phone_number(partial_url(), params)
  def info(number_id), do: Client.number_info(partial_url_with_id(number_id))
  def update(number_id, params), do: Client.update_number(partial_url_with_id(number_id), params)
  def delete(number_id), do: Client.delete_number(partial_url_with_id(number_id))

  def partial_url, do: "users/#{user_id()}/phoneNumbers"
  def partial_url_with_id(number_id), do: "users/#{user_id()}/phoneNumbers/#{number_id}"

end
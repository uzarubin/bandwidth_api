defmodule BandwidthApi.Endpoints.PhoneNumbers do

  alias BandwidthApi.Client
  import BandwidthApi.Config, only: [
    user_id: 0,
    account_id: 0
  ]

  ############################
  # Bandwidth App
  def search(params), do: Client.list_phone_numbers(partial_url(:app), params)
  def order(params), do: Client.order_phone_number(partial_url(:app), params)
  def info(number_id), do: Client.number_info(partial_url_with_id(:app, number_id))
  def update(number_id, params), do: Client.update_number(partial_url_with_id(:app, number_id), params)
  def delete(number_id), do: Client.delete_number(partial_url_with_id(:app, number_id))


  ############################
  # Bandwidth Dashboard
  def dashboard_order(params), do: Client.order_phone_number_via_dashboard(partial_url(:dashboard), params)
  def dashboard_order_info(order_id), do: Client.dashboard_order_info(partial_url_with_id(:dashboard, order_id))

  def partial_url(:dashboard), do: "accounts/#{account_id()}/orders"
  def partial_url(:app), do: "users/#{user_id()}/phoneNumbers"
  def partial_url_with_id(:dashboard, order_id), do: "accounts/#{account_id()}/orders/#{order_id}"
  def partial_url_with_id(:app, number_id), do: "users/#{user_id()}/phoneNumbers/#{number_id}"


end
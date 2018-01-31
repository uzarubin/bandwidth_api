defmodule BandwidthApi.Endpoints.Messages do

  alias BandwidthApi.Client
  import BandwidthApi.Config, only: [user_id: 0]

  def search(params), do: Client.list_messages(partial_url(), params)
  def send(params), do: Client.send_message(partial_url(), params)
  def info(message_id), do: Client.message_info(partial_url(message_id))

  def partial_url, do: "users/#{user_id()}/messages"
  def partial_url(message_id), do: "users/#{user_id()}/messages/#{message_id}"
end
defmodule BandwidthApi.Endpoints.Calls do
  alias BandwidthApi.Client
  import BandwidthApi.Config, only: [user_id: 0]


  def play_audio(%{"callId" => call_id} = params), do: Client.play_audio(partial_url(call_id) <> "/audio", params)
  def update_call(%{"callId" => call_id} = params), do: Client.update_call(partial_url(call_id), params)


  def partial_url(call_id), do: "users/#{user_id()}/calls/#{call_id}"
end
defmodule BandwidthApi.Endpoints.NumberImports do

  alias BandwidthApi.Client
  import BandwidthApi.Config
  import BandwidthApi.Config, only: [user_id: 0]

  ################################
  # Imports from BandwidhtDashboard to Bandwidth App
  def import_number(phone_number), do: Client.import_number_from_dashboard(partial_url(), phone_number)


  def partial_url(), do: "users/#{user_id()}/phoneNumbers"
end
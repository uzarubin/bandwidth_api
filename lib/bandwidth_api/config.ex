defmodule BandwidthApi.Config do


  def application_id, do: from_env(:bandwidth_api, :application_id)
  def user_id, do: from_env(:bandwidth_api, :user_id)
  def api_token, do: from_env(:bandwidth_api, :api_token)
  def api_secret, do: from_env(:bandwidth_api, :api_secret)
  def account_id, do: from_env(:bandwidth_api, :account_id)
  def username, do: from_env(:bandwidth_api, :username)
  def password, do: from_env(:bandwidth_api, :password)
  def site_id, do: from_env(:bandwidth_api, :site_id)
  def domain_name, do: "api.catapult.inetwork.com"


  def base_url(api_version), do: "https://#{domain_name()}/#{api_version}"
  def base_dashboard_url(), do: "https://dashboard.bandwidth.com/api"
  def from_env(app_name, key) do
    app_name
    |> Application.get_env(key)
    |> read_from_system()
  end

  defp read_from_system({:system, env}), do: System.get_env(env)
  defp read_from_system(value), do: value
end
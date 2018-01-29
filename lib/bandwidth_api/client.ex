defmodule BandwidthApi.Client do

  import BandwidthApi.Config, only: [base_url: 1, api_token: 0, api_secret: 0]

  alias HTTPoison
  alias Poison

  def list_local_numbers(partial_url, params) do
    make_request(:get, build_url(partial_url), "", build_headers(:form), params)
  end

  def order_local_number(partial_url, params) do
    body = params_to_map(params)
    make_request(:post, build_url(partial_url), Poison.encode!(body), build_headers(:json), params)
  end

  def list_toll_free_numbers(partial_url, params) do
    body = params_to_map(params)
    make_request(:get, build_url(partial_url), Poison.encode!(body), build_headers(:json), params)
  end

  def order_toll_free_number(partial_url, params) do
    body = params_to_map(params)
    make_request(:post, build_url(partial_url), Poison.encode!(body), build_headers(:json), params)
  end

  def make_request(method, url, body \\ "", headers, params \\ []) do
    HTTPoison.request(method, url, body, headers, [params: params])
  end

  def build_url(partial_url) do
      url = "v1" |> base_url()
      url <> "/#{partial_url}"
  end

  def build_headers(:form) do
    [auth_header()]
  end

  def build_headers(:json) do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"},
      auth_header()
    ]
  end

  def auth_header, do: {"Authorization", "Basic #{:base64.encode("#{api_token()}:#{api_secret()}")}"}

  def params_to_map(params), do: params |> Enum.into(%{})
end
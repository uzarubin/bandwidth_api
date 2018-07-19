defmodule BandwidthApi.Client do

  import BandwidthApi.Config, only: [
    base_url: 1,
    base_dashboard_url: 0,
    api_token: 0,
    api_secret: 0,
    username: 0,
    password: 0,
    site_id: 0,
    application_id: 0,
    account_id: 0
  ]
  import XmlBuilder

  alias HTTPoison
  alias Poison

  ## Available Numbers endpoint calls
  def list_local_numbers(partial_url, params) do
    make_request(:get, build_url(partial_url), "", build_headers(:basic), params)
  end

  def list_dashboard_numbers(partial_url, params) do
    make_request(:get, build_dashboard_url(partial_url), "", build_headers(:xml), params)
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

  ## Phone Numbers endpoint calls

  def list_phone_numbers(partial_url, body) do
    make_request(:get, build_url(partial_url), Poison.encode!(body), build_headers(:json))
  end

  # Returns empty body on order
  def order_phone_number(partial_url, body) do
    make_request(:post, build_url(partial_url), Poison.encode!(body), build_headers(:json))
  end

  # Submits order for phone number via Bandwidth dashboard
  def order_phone_number_via_dashboard(partial_url, %{phone_number: phone_number}) do
    xml_payload = phone_number
                  |> gen_xml_payload()
                  |> XmlBuilder.generate()
    make_request(:post, build_dashboard_url(partial_url), xml_payload, build_headers(:xml))
  end

  # Fetches order status from Bandwidth dashboard
  def dashboard_order_info(partial_url) do
    make_request(:get, build_dashboard_url(partial_url), "", build_headers(:xml))
  end

  # Submits a request for number import
  def import_number_from_dashboard(partial_url, phone_number) do
    json_payload = phone_number
                   |> gen_import_payload()
                   |> Poison.encode!()
    make_request(:post, build_url(partial_url), json_payload, build_headers(:json))
  end


  # Can use phone number id or the number itself
  def number_info(partial_url) do
    make_request(:get, build_url(partial_url), "", build_headers(:json))
  end

  # Can use number or id, Returns empty body
  def update_number(partial_url, params) do
    make_request(:post, build_url(partial_url), Poison.encode!(params), build_headers(:json))
  end

  # Requires a number id, cannot use phone number
  def delete_number(partial_url) do
    make_request(:delete, build_url(partial_url), "", build_headers(:json))
  end

  ## Messages endpoint calls

  def list_messages(partial_url, params) do
    make_request(:get, build_url(partial_url), Poison.encode!(params), build_headers(:json), params)
  end

  def send_message(partial_url, params) do
    make_request(:post, build_url(partial_url), Poison.encode!(params), build_headers(:json))
  end

  def message_info(partial_url) do
    make_request(:get, build_url(partial_url), "", build_headers(:json))
  end

  ## Calls endpoints

  def play_audio(partial_url, params) do
    make_request(:post, build_url(partial_url), Poison.encode!(params), build_headers(:json))
  end

  def update_call(partial_url, params) do
    make_request(:post, build_url(partial_url), Poison.encode!(params), build_headers(:json))
  end

  ## Helpers

  def make_request(method, url, body \\ "", headers, params \\ []) do
    HTTPoison.request(method, url, body, headers, [params: params])
  end

  def build_url(partial_url), do: base_url("v1") <> "/#{partial_url}"
  def build_dashboard_url(partial_url), do: base_dashboard_url() <> "/#{partial_url}"

  def build_headers(:basic) do
    [auth_header()]
  end

  def build_headers(:xml) do
    [
      {"Content-Type", "application/xml; charset=utf-8"},
      auth_header_dashboard()
    ]
  end

  def build_headers(:json) do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"},
      auth_header()
    ]
  end

  def auth_header, do: {"Authorization", "Basic #{:base64.encode("#{api_token()}:#{api_secret()}")}"}
  def auth_header_dashboard, do: {"Authorization", "Basic #{:base64.encode("#{username()}:#{password()}")}"}
  def params_to_map(params), do: params |> Enum.into(%{})

  @doc"""
  Generates XML payload for phone number orders via Bandwidth Dashboard
  Requires phone number in the E.164 format
  """
  def gen_xml_payload(phone_number) do
    element(:Order, [
      element(:SiteId, site_id()),
      element(:ExistingTelephoneNumberOrderType, [
        element(:TelephoneNumberList, [
          element(:TelephoneNumber, phone_number)
        ])
      ])
    ])
  end

  @doc"""
  Generates payload for phone number imports
  """
  def gen_import_payload("+1" <> _ = phone_number) do
    %{
      number: phone_number,
      applicationId: application_id(),
      name: "imported_number",
      provider: %{
        providerName: "bandwidth-dashboard",
        properties: %{
          accountId: account_id(),
          userName: username(),
          password: password()
        }
      }
    }
  end

end
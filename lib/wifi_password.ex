defmodule WifiPassword do
  @moduledoc """
  Documentation for `WifiPassword`.
  """

  @spec get(binary) :: {:error, :denied | :not_found} | {:ok, binary}
  @doc """
  Returns the password of your a given router based on its ssid

  ## Examples

      iex> WifiPassword.get("my-router")
      {:ok, "YoUrWiFiPasSwOrD"}

      iex> WifiPassword.get("my-invalid-router")
      {:error, :not_found}
  """
  def get(ssid) do
    os = :os.type()

    case os do
      {:unix, :darwin} ->
        case System.cmd("security", [
               "find-generic-password",
               "-wa",
               ssid
             ]) do
          {_any, 128} ->
            {:error, :denied}

          {_any, 44} ->
            {:error, :not_found}

          {passwd, 0} ->
            {:ok, passwd |> String.replace("\n", "")}
        end

      {:unix, :linux} ->
        case System.cmd("nmcli", [
               "--show-secrets",
               "--mode",
               "tabular",
               "--terse",
               "--fields",
               "802-11-wireless-security.psk,802-11-wireless-security.wep-key0",
               "connection",
               "show",
               "id",
               ssid
             ]) do
          {_any, 10} ->
            {:error, :not_found}

          {passwd, 0} ->
            {:ok, passwd |> String.replace(~r/^--$/m, "") |> String.replace("\n", "")}
        end

      {:win32, :nt} ->
        {:error, :not_implemented}
    end
  end
end

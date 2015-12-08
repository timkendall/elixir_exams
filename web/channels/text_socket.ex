defmodule Wimf.TextSocket do
  use Phoenix.Socket

  channel "texts", Wimf.TextChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end

defmodule Wimf.ICSController do
  use Wimf.Web, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/calendar")
    |> render "event.ics"
  end
end

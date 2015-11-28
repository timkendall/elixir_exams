defmodule Wimf.SMSController do
  use Wimf.Web, :controller

  def incoming(conn, _params) do
    #IO.puts "What up"
    #render conn, "response.json", data: %{ message: "What up! -From Elixir" }
    conn
    |> put_resp_content_type("text/xml")
    |> render "incoming.xml" #, some_xml_content
  end
end

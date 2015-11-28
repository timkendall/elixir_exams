defmodule Wimf.PageController do
  use Wimf.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

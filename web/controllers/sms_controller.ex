defmodule Wimf.SMSController do
  use Wimf.Web, :controller

  alias Wimf.Text
  alias Wimf.Reply

  @default_reply "What up sucka!"

  def craft_reply(text) do
    # Create new `Reply` and associate it with a `Text`
    reply = Ecto.Model.build(text, :reply, message: @default_reply)

    # Save it
    Repo.insert(reply)
  end

  def incoming(conn, params) do
    from = params["From"]
    message = params["Body"]

    # Create a new `Text`
    changeset = Text.changeset(%Text{}, %{
      from: from,
      message: message })

    # Emit over socket to client
    Wimf.Endpoint.broadcast! "texts", "new:text", %{from: from, message: message}

    # Save the `Text`
    case Repo.insert(changeset) do
      {:ok, text} ->
        IO.inspect text

        case craft_reply(text) do
          {:ok, reply} ->
            IO.inspect reply
          {:error, changeset} ->
            IO.puts "Failed to save reply!!!!!"
        end

      {:error, changeset} ->
        IO.puts "Failed to save text!!!!!"
    end

    conn
    |> put_resp_content_type("text/xml")
    |> render "incoming.xml", reply: "Testing 123"
  end
end

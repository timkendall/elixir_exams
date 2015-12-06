defmodule Wimf.SMSController do
  use Wimf.Web, :controller

  alias Wimf.Text
  alias Wimf.Reply

  @default_reply "What up sucka!"

  def craft_reply(text) do
    # Create new `Reply`
    #changeset = Reply.changeset(%Reply{}, %{
      #message: @default_reply,
      #text_id: text.id })

    reply = Ecto.Model.build(text, :reply, message: @default_reply)

    # Save it
    Repo.insert(reply)
  end

  def incoming(conn, params) do
    # Create a new `Text`
    changeset = Text.changeset(%Text{}, %{
      from: params["From"],
      message: params["Body"] })

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

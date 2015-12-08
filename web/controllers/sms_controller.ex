defmodule Wimf.SMSController do
  use Wimf.Web, :controller

  alias Wimf.Text
  alias Wimf.Reply

  @default_reply "Sorry I couldn't find an exam time for that."

  def normalize_course(course_id) do
    String.downcase(course_id)
  end

  def match_reply(text) do
    message = text.message
      |> normalize_course

    # TODO - Parse course ID from message
    # TODO - Query database

    cond do
      String.contains? message, ["cpsc-350"] ->
        craft_reply text, "Your final is Wednesday December 18th at 9:15am."
      String.contains? message, ["art-101"] ->
        craft_reply text, "Your final is Tuesday December 17th at 2:00pm."
      String.contains? message, ["math-280"] ->
        craft_reply text, "Congratulations, you don't have a final!"
      true ->
        craft_reply text, @default_reply
    end
  end

  def craft_reply(text, reply_message) do
    # Create new `Reply` and associate it with a `Text`
    reply = Ecto.Model.build(text, :reply, message: reply_message)
    # Send over socket to client
    Wimf.Endpoint.broadcast! "texts", "new:text", %{from: "Elixir", message: reply_message}
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

        case match_reply(text) do
          {:ok, reply} ->
            IO.inspect reply
            conn
            |> put_resp_content_type("text/xml")
            |> render "incoming.xml", reply: reply.message
          {:error, changeset} ->
            IO.puts "Failed to save reply!!!!!"
        end

      {:error, changeset} ->
        IO.puts "Failed to save text!!!!!"
    end
  end
end

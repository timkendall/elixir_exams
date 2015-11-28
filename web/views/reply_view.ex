defmodule Wimf.ReplyView do
  use Wimf.Web, :view

  def render("index.json", %{replies: replies}) do
    %{data: render_many(replies, Wimf.ReplyView, "reply.json")}
  end

  def render("show.json", %{reply: reply}) do
    %{data: render_one(reply, Wimf.ReplyView, "reply.json")}
  end

  def render("reply.json", %{reply: reply}) do
    %{id: reply.id,
      message: reply.message}
  end
end

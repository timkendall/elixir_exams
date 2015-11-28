defmodule Wimf.TextView do
  use Wimf.Web, :view

  def render("index.json", %{texts: texts}) do
    %{data: render_many(texts, Wimf.TextView, "text.json")}
  end

  def render("show.json", %{text: text}) do
    %{data: render_one(text, Wimf.TextView, "text.json")}
  end

  def render("text.json", %{text: text}) do
    %{id: text.id,
      from: text.from,
      message: text.message}
  end
end

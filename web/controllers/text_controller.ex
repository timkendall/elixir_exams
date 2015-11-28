defmodule Wimf.TextController do
  use Wimf.Web, :controller

  alias Wimf.Text

  plug :scrub_params, "text" when action in [:create, :update]

  def index(conn, _params) do
    texts = Repo.all(Text)
    render(conn, "index.json", texts: texts)
  end

  def create(conn, %{"text" => text_params}) do
    changeset = Text.changeset(%Text{}, text_params)

    case Repo.insert(changeset) do
      {:ok, text} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", text_path(conn, :show, text))
        |> render("show.json", text: text)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Wimf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    text = Repo.get!(Text, id)
    render(conn, "show.json", text: text)
  end

  def update(conn, %{"id" => id, "text" => text_params}) do
    text = Repo.get!(Text, id)
    changeset = Text.changeset(text, text_params)

    case Repo.update(changeset) do
      {:ok, text} ->
        render(conn, "show.json", text: text)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Wimf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    text = Repo.get!(Text, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(text)

    send_resp(conn, :no_content, "")
  end
end

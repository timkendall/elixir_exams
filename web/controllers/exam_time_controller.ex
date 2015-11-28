defmodule Wimf.ExamTimeController do
  use Wimf.Web, :controller

  alias Wimf.ExamTime

  plug :scrub_params, "exam_time" when action in [:create, :update]

  def index(conn, _params) do
    exam_times = Repo.all(ExamTime)
    render(conn, "index.json", exam_times: exam_times)
  end

  def create(conn, %{"exam_time" => exam_time_params}) do
    changeset = ExamTime.changeset(%ExamTime{}, exam_time_params)

    case Repo.insert(changeset) do
      {:ok, exam_time} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", exam_time_path(conn, :show, exam_time))
        |> render("show.json", exam_time: exam_time)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Wimf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    exam_time = Repo.get!(ExamTime, id)
    render(conn, "show.json", exam_time: exam_time)
  end

  def update(conn, %{"id" => id, "exam_time" => exam_time_params}) do
    exam_time = Repo.get!(ExamTime, id)
    changeset = ExamTime.changeset(exam_time, exam_time_params)

    case Repo.update(changeset) do
      {:ok, exam_time} ->
        render(conn, "show.json", exam_time: exam_time)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Wimf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    exam_time = Repo.get!(ExamTime, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(exam_time)

    send_resp(conn, :no_content, "")
  end
end

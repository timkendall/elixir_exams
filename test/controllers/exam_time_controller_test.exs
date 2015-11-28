defmodule Wimf.ExamTimeControllerTest do
  use Wimf.ConnCase

  alias Wimf.ExamTime
  @valid_attrs %{day_of_month: 42, day_of_week: 42, month: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, exam_time_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    exam_time = Repo.insert! %ExamTime{}
    conn = get conn, exam_time_path(conn, :show, exam_time)
    assert json_response(conn, 200)["data"] == %{"id" => exam_time.id,
      "month" => exam_time.month,
      "day_of_month" => exam_time.day_of_month,
      "day_of_week" => exam_time.day_of_week}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, exam_time_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, exam_time_path(conn, :create), exam_time: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ExamTime, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, exam_time_path(conn, :create), exam_time: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    exam_time = Repo.insert! %ExamTime{}
    conn = put conn, exam_time_path(conn, :update, exam_time), exam_time: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ExamTime, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    exam_time = Repo.insert! %ExamTime{}
    conn = put conn, exam_time_path(conn, :update, exam_time), exam_time: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    exam_time = Repo.insert! %ExamTime{}
    conn = delete conn, exam_time_path(conn, :delete, exam_time)
    assert response(conn, 204)
    refute Repo.get(ExamTime, exam_time.id)
  end
end

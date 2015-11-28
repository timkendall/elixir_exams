defmodule Wimf.ReplyControllerTest do
  use Wimf.ConnCase

  alias Wimf.Reply
  @valid_attrs %{message: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reply_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = get conn, reply_path(conn, :show, reply)
    assert json_response(conn, 200)["data"] == %{"id" => reply.id,
      "message" => reply.message}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, reply_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, reply_path(conn, :create), reply: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Reply, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reply_path(conn, :create), reply: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = put conn, reply_path(conn, :update, reply), reply: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Reply, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = put conn, reply_path(conn, :update, reply), reply: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = delete conn, reply_path(conn, :delete, reply)
    assert response(conn, 204)
    refute Repo.get(Reply, reply.id)
  end
end

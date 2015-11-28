defmodule Wimf.TextTest do
  use Wimf.ModelCase

  alias Wimf.Text

  @valid_attrs %{from: "some content", message: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Text.changeset(%Text{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Text.changeset(%Text{}, @invalid_attrs)
    refute changeset.valid?
  end
end

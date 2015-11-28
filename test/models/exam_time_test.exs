defmodule Wimf.ExamTimeTest do
  use Wimf.ModelCase

  alias Wimf.ExamTime

  @valid_attrs %{day_of_month: 42, day_of_week: 42, month: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ExamTime.changeset(%ExamTime{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ExamTime.changeset(%ExamTime{}, @invalid_attrs)
    refute changeset.valid?
  end
end

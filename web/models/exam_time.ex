defmodule Wimf.ExamTime do
  use Wimf.Web, :model

  schema "exam_times" do
    field :month, :integer
    field :day_of_month, :integer
    field :day_of_week, :integer
    field :minutes, :integer
    field :course_id_matches, {:array, :string}, default: []

    timestamps
  end

  @required_fields ~w(month day_of_month day_of_week minutes)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

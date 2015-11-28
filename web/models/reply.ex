defmodule Wimf.Reply do
  use Wimf.Web, :model
  alias Wimf.Text

  schema "replies" do
    field :message, :string
    belongs_to :text, Text

    timestamps
  end

  @required_fields ~w(message)
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

defmodule Wimf.Text do
  use Wimf.Web, :model
  alias Wimf.Reply

  schema "texts" do
    field :from, :string
    field :message, :string
    has_one :reply, Reply

    timestamps
  end

  @required_fields ~w(from message)
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

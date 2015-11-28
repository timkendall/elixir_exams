defmodule Wimf.Repo.Migrations.CreateReply do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :message, :string
      add :text_id, :integer # references(:texts)

      timestamps
    end

  end
end

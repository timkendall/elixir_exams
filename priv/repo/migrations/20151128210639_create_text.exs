defmodule Wimf.Repo.Migrations.CreateText do
  use Ecto.Migration

  def change do
    create table(:texts) do
      add :from, :string
      add :message, :string
      add :reply_id, :integer # references(:replies)

      timestamps
    end

  end
end

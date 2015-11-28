defmodule Wimf.Repo.Migrations.CreateExamTime do
  use Ecto.Migration

  def change do
    create table(:exam_times) do
      add :month, :integer
      add :day_of_month, :integer
      add :day_of_week, :integer
      add :minutes, :integer
      add :course_id_matches, {:array, :string}

      timestamps
    end

  end
end

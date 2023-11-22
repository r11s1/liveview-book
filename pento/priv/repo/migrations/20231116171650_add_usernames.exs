defmodule Pento.Repo.Migrations.AddUsernames do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false
    end

    create unique_index(:users, [:username])

  end
end

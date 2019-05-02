defmodule Tphx.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string, size: 255,  null: false
      add :slug, :string,  null: false
      add :price, :bigint,  null: false
      add :description, :text, null: true

      timestamps()
    end

     create(unique_index(:products, [:slug]))

  end
end

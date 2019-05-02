defmodule Tphx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset  
  #import Comeonin.Bcrypt#, only: [hash_pwd_salt: 2]


  schema "users" do
    field :email, :string
    field :password_digest, :string
    field :username, :string
    
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :role, Tphx.Accounts.Role
    
    timestamps()    
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> validate_length(:username, min: 1, max: 255)    
    |> hash_password
  end


  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do      
      changeset
      |> put_change(:password_digest, Bcrypt.hash_pwd_salt(password))
    else
      changeset  
    end  
  end

end

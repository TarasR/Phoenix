defmodule Tphx.Accounts.RoleChecker do
  alias Tphx.Repo
  alias Tphx.Role

  def is_admin?(user) do
    role = Repo.get(Role, user.role_id) #&& 
    role.admin
  end

end
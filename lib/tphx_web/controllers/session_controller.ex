defmodule TphxWeb.SessionController do
   use TphxWeb, :controller 

   alias Tphx.Accounts
   alias Tphx.Accounts.User
   alias Tphx.Repo

#   alias Comeonin

#   import Comeonin.Bcrypt#, only: [verify_pass: 2, dummy_checkpw: 0]
   plug :scrub_params, "user" when action in [:create]



    def new(conn, _params) do
       changeset = Accounts.change_user(%User{})
       render(conn, "new.html", changeset: changeset)    
    end

    def create(conn, %{"user"=>%{"username"=>username, "password"=>password}}) when not is_nil(username) and not is_nil(password) do
        user=Repo.get_by(User, username: username)
        sign_in(user, password, conn)
    end       
       #Repo.get_by(User, username: user_params["username"] ) 
       #|>sign_in(user_params["password"], conn) 
    

    def create(conn, _) do
        failed_login(conn)
    end

    defp failed_login(conn) do
        Bcrypt.no_user_verify()
        conn
        |> put_session(:current_user, nil)
        |> put_flash(:error, "Invalid username/password combination!")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end

    defp sign_in(user, password, conn) when is_nil(user) do
       failed_login(conn)
       #conn
       #|> put_flash(:error, "Invalid username/password combination!")
       #|> redirect(to: Routes.page_path(conn, :index))
    end

    defp sign_in(user, password, conn) do
       #if checkpw(password, user.password_digest) do
        if Bcrypt.verify_pass(password, user.password_digest) do
           conn
           |> put_session(:current_user, %{id: user.id, username: user.username, role_id: user.role_id})
           |> put_flash(:info, "Sign in successful!")
           |> redirect(to: Routes.page_path(conn, :index))
        else
           failed_login(conn)
           #conn
           #|> put_session(:current_user, nil)
           #|> put_flash(:error, "Invalid username/password combination!")
           #|> redirect(to: Routes.page_path(conn, :index))
        end
    end

    def delete(conn, _params) do
        conn
        |> delete_session(:current_user)
        |> put_flash(:info, "Signed out successfully!")
        |> redirect(to: Routes.page_path(conn, :index))
    end
   

end
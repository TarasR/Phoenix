defmodule TphxWeb.PageController do
  use TphxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

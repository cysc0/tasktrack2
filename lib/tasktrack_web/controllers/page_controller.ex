defmodule Tasktrack2Web.PageController do
    use Tasktrack2Web, :controller
  
    def index(conn, _params) do
      render conn, "index.html"
    end
  end
  
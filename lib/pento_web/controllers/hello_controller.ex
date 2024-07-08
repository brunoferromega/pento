defmodule PentoWeb.HelloController do
  use PentoWeb, :controller

  def index(conn, _parans) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end

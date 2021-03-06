defmodule AlchemyWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AlchemyWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AlchemyWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {what, is}) do
    IO.inspect what
    IO.inspect is
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Login error"})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(AlchemyWeb.ErrorView)
    |> render(:"404")
  end
end

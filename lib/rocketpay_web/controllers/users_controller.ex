defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def create(connection, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      connection
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  defp handle_response({:error, _reason} = error, _connection), do: error
  # defp handle_response({:error, reason}, connection) do
  #   connection
  #   |> put_status(:bad_request)
  #   |> put_view(RocketpayWeb.ErrorView)
  #   |> render("400.json", result: reason)
  # end
end

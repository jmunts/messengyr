defmodule Messengyr.Accounts.Session do
  alias Messengyr.Accounts.User
  alias Messengyr.Repo

  def authenticate(%{"username" => username, "password" => password}) do
    user = Repo.get_by(User, username: username)

    check_password(user, password)
  end

  defp check_password(nil, _password) do
    {:error, "No user with this username was found!"}
  end

  defp check_password(%{encrypted_password: encrypted_password} = user, password) do
    case Comeonin.Bcrypt.checkpw(password, encrypted_password) do
      true -> {:ok, user}
      _    -> {:error, "Incorrect password"}
    end
  end

end

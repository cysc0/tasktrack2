defmodule Tasktrack2.Timelogs do
  @moduledoc """
  The Timelogs context.
  """

  import Ecto.Query, warn: false
  alias Tasktrack2.Repo

  alias Tasktrack2.Timelogs.Timelog

  @doc """
  Returns the list of timelogs.

  ## Examples

      iex> list_timelogs()
      [%Timelog{}, ...]

  """
  def list_timelogs do
    Repo.all(Timelog)
  end

  @doc """
  Gets a single timelog.

  Raises `Ecto.NoResultsError` if the Timelog does not exist.

  ## Examples

      iex> get_timelog!(123)
      %Timelog{}

      iex> get_timelog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timelog!(id), do: Repo.get!(Timelog, id)

  @doc """
  Creates a timelog.

  ## Examples

      iex> create_timelog(%{field: value})
      {:ok, %Timelog{}}

      iex> create_timelog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timelog(attrs \\ %{}) do
    %Timelog{}
    |> Timelog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timelog.

  ## Examples

      iex> update_timelog(timelog, %{field: new_value})
      {:ok, %Timelog{}}

      iex> update_timelog(timelog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timelog(%Timelog{} = timelog, attrs) do
    timelog
    |> Timelog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timelog.

  ## Examples

      iex> delete_timelog(timelog)
      {:ok, %Timelog{}}

      iex> delete_timelog(timelog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timelog(%Timelog{} = timelog) do
    Repo.delete(timelog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timelog changes.

  ## Examples

      iex> change_timelog(timelog)
      %Ecto.Changeset{source: %Timelog{}}

  """
  def change_timelog(%Timelog{} = timelog) do
    Timelog.changeset(timelog, %{})
  end
end

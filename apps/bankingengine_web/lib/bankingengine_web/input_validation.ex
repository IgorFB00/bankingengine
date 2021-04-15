defmodule BankingengineWeb.InputValidation do
  @moduledoc """
  Validates a given map of params whith the given schema
  """

  @doc """
  Apply the changeset function of the given module passing params.
  """
  def cast_and_apply(params, module) do
    case module.changeset(params) do
      %{valid?: true} = changeset ->
        {:ok, Ecto.Changeset.apply_changes(changeset)}

      %{valid?: false} = changeset ->
        IO.inspect(changeset)
        {:error, changeset}
    end
  end
end

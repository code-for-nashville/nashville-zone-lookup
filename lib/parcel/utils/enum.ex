defmodule Parcel.Utils.Enum do
  @doc """
  Like `Enum.group_by`, but the value is a single element instead of a list.

  ## Example

      iex> Parcel.Utils.Enum.index_by(
      ...>  [%{name: "Tom", age: 10}, %{name: "Mary", age: 40}],
      ...>  fn person -> person.name end
      ...> )
      %{
        "Tom" => %{name: "Tom", age: 10},
        "Mary" => %{name: "Mary", age: 40},
      }
  """
  def index_by(enumerable, key_fun, value_fun \\ fn x -> x end) do
    Enum.group_by(enumerable, key_fun, value_fun)
    # Map over key/value pairs and return a tuple of {key, last_value}
    |> Enum.map(fn {key, values} -> {key, List.last(values)} end)
    # Transforms list of key/value tuples back into a map
    |> Enum.into(%{})
  end
end

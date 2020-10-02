defmodule XmlParse.People.Person do
  @type t :: %__MODULE__{name: String.t(), age: integer()}

  defstruct [:name, :age]
end

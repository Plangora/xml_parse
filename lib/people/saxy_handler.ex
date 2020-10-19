defmodule XmlParse.People.SaxyHandler do
  @behaviour Saxy.Handler
  alias XmlParse.People.Person

  defstruct people: [], current_person: nil, current_field: nil

  def handle_event(:start_document, _prolog, _state), do: {:ok, %__MODULE__{}}

  def handle_event(:end_document, _data, %{people: people}), do: {:ok, Enum.reverse(people)}

  def handle_event(:start_element, {"person", _attrs}, state),
    do: {:ok, %{state | current_person: %Person{}}}

  def handle_event(:start_element, {"name", _attrs}, state) do
    {:ok, %{state | current_field: :name}}
  end

  def handle_event(:start_element, {"age", _attrs}, state) do
    {:ok, %{state | current_field: :age}}
  end

  def handle_event(:start_element, _data, state), do: {:ok, state}

  def handle_event(:end_element, "person", state) do
    {:ok, %{state | people: [state.current_person | state.people], current_person: nil}}
  end

  def handle_event(:end_element, _element, state),
      do: {:ok, %{state | current_field: nil}}

  def handle_event(:characters, chars, %{current_field: :name} = state) do
    {:ok, %{state | current_person: %{state.current_person | name: chars}}}
  end

  def handle_event(:characters, chars, %{current_field: :age} = state) do
    age = String.to_integer(chars)
    {:ok, %{state | current_person: %{state.current_person | age: age}}}
  end

  def handle_event(:characters, _chars, state), do: {:ok, state}
end

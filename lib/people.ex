defmodule XmlParse.People do
  alias XmlParse.People.Person
  import SweetXml, only: [sigil_x: 2]

  @spec sweet_xml_parse(String.t()) :: [Person.t()]
  def sweet_xml_parse(xml_string) do
    %{people: people} =
      SweetXml.xmap(xml_string,
        people: [~x"//person"l, name: ~x"./name/text()"s, age: ~x"./age/text()"i]
      )

    Enum.map(people, fn %{name: name, age: age} ->
      %Person{name: name, age: age}
    end)
  end
end

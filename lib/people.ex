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

  @spec sweet_xml_parse_stream(FileStream.t()) :: [Person.t()]
  def sweet_xml_parse_stream(xml_stream) do
      SweetXml.stream_tags(xml_stream, :people, discard: [:people])
      |> Enum.map(fn {_, doc} ->
        %{people: people} = SweetXml.xmap(doc, people: [~x"//person"l, name: ~x"./name/text()"s, age: ~x"./age/text()"i])
        Enum.map(people, fn %{name: name, age: age} ->
          %Person{name: name, age: age}
        end)
    end)
    |> List.flatten()
  end

  @spec saxy_parse(String.t()) :: [Person.t()]
  def saxy_parse(xml_string) do
    {:ok, people} = Saxy.parse_string(xml_string, XmlParse.People.SaxyHandler, nil)
    people
  end

  @spec saxy_parse_stream(FileStream.t()) :: [Person.t()]
  def saxy_parse_stream(xml_stream) do
    {:ok, people} = Saxy.parse_stream(xml_stream, XmlParse.People.SaxyHandler, nil)
    people
  end

  @spec nif_parse(String.t()) :: [Person.t()]
  def nif_parse(xml_string) do
    XmlParse.Native.parse(xml_string)
  end
end

defmodule XmlParse.PeopleTest do
  use ExUnit.Case, async: true
  alias XmlParse.{People, People.Person}

  setup do
    {:ok, xml_data} =
      ["test", "support", "test.xml"]
      |> Path.join()
      |> File.read()

    {:ok, xml: xml_data}
  end

  test "use Sweet Xml to parse out people", %{xml: xml_data} do
    assert [%Person{name: "Bob", age: 20}, %Person{name: "Jane", age: 18}] ==
             People.sweet_xml_parse(xml_data)
  end

  test "use Saxy to parse out people", %{xml: xml_data} do
    assert [%Person{name: "Bob", age: 20}, %Person{name: "Jane", age: 18}] ==
             People.saxy_parse(xml_data)
  end
end

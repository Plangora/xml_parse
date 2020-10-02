defmodule XmlParse.PeopleTest do
  use ExUnit.Case, async: true
  alias XmlParse.{People, People.Person}

  test "use Sweet Xml to parse out people" do
    {:ok, xml_data} =
      ["test", "support", "test.xml"]
      |> Path.join()
      |> File.read()

    assert [%Person{name: "Bob", age: 20}, %Person{name: "Jane", age: 18}] ==
             People.sweet_xml_parse(xml_data)
  end
end

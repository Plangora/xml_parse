{:ok, xml_data} =
  ["test", "support", "test.xml"]
  |> Path.join()
  |> File.read()

Benchee.run(%{"sweet_xml" => fn ->
    XmlParse.People.sweet_xml_parse(xml_data)
  end,
  "saxy" => fn ->
    XmlParse.People.saxy_parse(xml_data)
  end
}, memory_time: 0.1, warmup: 0)
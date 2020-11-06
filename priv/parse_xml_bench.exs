  path =
  ["test", "support", "test.xml"]
  |> Path.join()

  xml_stream = File.stream!(path)

Benchee.run(%{"sweet_xml" => fn ->
    XmlParse.People.sweet_xml_parse_stream(xml_stream)
  end,
  "saxy" => fn ->
    XmlParse.People.saxy_parse_stream(xml_stream)
  end,
  "nif" => fn ->
    {:ok, xml_data} = File.read(path)
    XmlParse.People.nif_parse(xml_data)
  end
}, memory_time: 0.1, warmup: 0)
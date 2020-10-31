defmodule XmlParse.Native do
  use Rustler, otp_app: :xml_parse, crate: "xmlparse_native"

  # When your NIF is loaded, it will override this function.
  def parse(_xml_data), do: :erlang.nif_error(:nif_not_loaded)
end

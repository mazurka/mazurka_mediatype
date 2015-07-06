defmodule Mazurka.Mediatype.Parser.Utils do
  @mediatype_key :mazurka_mediatype

  def partial_name(name) do
    "#{name}_partial" |> String.to_atom
  end
end
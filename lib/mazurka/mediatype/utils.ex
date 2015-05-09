defmodule Mazurka.Mediatype.Utils do
  @mediatype_key :mazurka_mediatype

  def get_mediatype(conn) do
    Dict.get(conn.private, @mediatype_key, {nil, nil, nil})
  end

  def put_mediatype(%{private: private} = conn, value) do
    %{conn | private: Map.put(private, @mediatype_key, value)}
  end

  def partial_name(name) do
    "#{name}_partial" |> String.to_atom
  end
end
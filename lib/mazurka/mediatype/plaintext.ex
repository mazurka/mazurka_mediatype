defmodule Mazurka.Mediatype.Plaintext do
  def parse(src, _opts \\ []) do
    {:ok, [to_string(src)]}
  end

  def serialize(bin, _opts \\ []) do
    bin
  end
end
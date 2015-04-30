defmodule Mazurka.Mediatype do
  alias Mazurka.Mediatype.SyntaxError

  def parse(line, file, contents, mediatypes) do
    parser = find_valid_parser(mediatypes)
    if !parser, do: raise "#{inspect(mediatypes)} mediatype compiler could not be loaded"

    chars = to_chars(contents)
    opts = [line: line, file: file]

    case apply(parser, :parse, [chars, opts]) do
      {:ok, ast} ->
        {:ok, ast, parser}
      {:error, {eline, _, {:illegal, token}}} ->
        raise SyntaxError, {eline, file, {line, contents}, "illegal token: #{token}"}
      {:error, {eline, _, [error, token]}} ->
        raise SyntaxError, {eline, file, {line, contents}, "#{error}#{token}"}
    end
  end

  defp find_valid_parser(name) when not is_list(name) do
    find_valid_parser([name])
  end
  defp find_valid_parser(names) do
    names
    |> Enum.reduce([], fn
      (name, acc) when is_binary(name) ->
        name = String.capitalize(name) |> String.replace("+", "")
        [Module.concat([name]), Module.concat(["Mazurka.Mediatype", name]) | acc]
      (name, acc) ->
        [name | acc]
    end)
    |> Enum.find(&Code.ensure_loaded?/1)
  end

  defp to_chars(bin) do
    case :unicode.characters_to_list(bin) do
      l when is_list(l) -> l
      _ -> :erlang.binary_to_list(bin)
    end
  end

end
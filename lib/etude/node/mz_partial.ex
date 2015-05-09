defmodule Etude.Node.MzPartial do
  defstruct module: nil,
            function: nil,
            props: %{},
            line: 1

  alias Etude.Children
  import Etude.Vars
  import Etude.Utils
  
  defimpl Etude.Node, for: Etude.Node.MzPartial do
    defdelegate assign(node, opts), to: Etude.Node.Etude.Node.Partial
    defdelegate call(node, opts), to: Etude.Node.Etude.Node.Partial
    defdelegate children(node), to: Etude.Node.Etude.Node.Partial
    defdelegate set_children(node, props), to: Etude.Node.Etude.Node.Partial
    defdelegate name(node, opts), to: Etude.Node.Etude.Node.Partial
    defdelegate prop(node, opts), to: Etude.Node.Etude.Node.Partial
    defdelegate var(node, opts), to: Etude.Node.Etude.Node.Partial

    def compile(node, opts) do
      mod = node.module
      fun = node.function |> Mazurka.Mediatype.Utils.partial_name
      props = node.props
      scope = :erlang.phash2({mod, fun, props})

      defop node, opts, [:memoize], """
      Props = #{Children.props(props, opts)},
      {Type, Subtype, Params} = 'Elixir.Mazurka.Mediatype.Utils':get_mediatype(#{state}),
      #{child_scope(scope)},
      #{debug_call(mod, fun, "[Props]", opts)},
      #{escape(mod)}:#{escape(fun)}(Type, Subtype, Params, #{op_args}, Props)
      """, Children.compile(Map.values(props), opts)
    end
  end
end
# config/.credo.exs
%{
  configs: [
    %{
      name: "default",
      checks: [
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false},
        {Credo.Check.Readability.LargeNumbers},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs, parens: true}
      ]
    }
  ]
}

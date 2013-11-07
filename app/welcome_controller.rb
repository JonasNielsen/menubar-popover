class WelcomeController < NSViewController
  stylesheet :welcome

  layout(nil, :root) do
    subview(NSTextField, :welcome_text)
  end
end
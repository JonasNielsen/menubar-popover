Teacup::Stylesheet.new :welcome do
  
  style :root,
    frame: [[0,0],[250,250]]

    style :welcome_text,
      frame: [[0,130],['100%', 50]],
      stringValue: "Follow me at @jonasnielsen",
      alignment: NSCenterTextAlignment,
      bezeled: false,
      drawsBackground: false,
      editable: false,
      selectable: false
end
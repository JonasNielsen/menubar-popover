class Menubar
  attr_reader :status_item

  def initialize click_delegate
    @click_delegate = click_delegate
    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength)
    @status_item.setTitle("@jonasnielsen")
    @status_item.setHighlightMode(true)
    @status_item.setTarget(self)
    @status_item.setAction('mouseDown:')
  end

  def mouseDown status_item_view
    @click_delegate.menubar_app_icon_clicked(status_item_view)
  end
end
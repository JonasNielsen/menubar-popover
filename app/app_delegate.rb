class AppDelegate
  def applicationDidFinishLaunching notification 
    @menubar = Menubar.new self
    @popover_controller = PopoverController.new
  end

  def menubar_app_icon_clicked status_item_view
    @popover_controller.toggle(status_item_view)
  end
end

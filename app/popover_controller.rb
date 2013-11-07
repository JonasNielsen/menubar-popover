class PopoverController

  def initialize
    @displaying = false
    # register_observers
  end

  def toggle from_status_item_view
    @last_known_view = from_status_item_view
    if @displaying
      close
    else
      NSApp.activateIgnoringOtherApps(true) # makes popover key
      display
    end
  end

  def display
    update_view_controller
    popover.showRelativeToRect(NSZeroRect, ofView: @last_known_view, preferredEdge: CGRectMaxYEdge)
    @displaying = true
  end

  def close
    popover.close # calls delegate method popoverDidClose on self
  end

  def update_view_controller
    popover.setContentViewController(view_controller_for_state)
    popover.setContentSize(view_controller_for_state.view.frame.size)
  end

  private

  # My interface state is configured in a state machine
  # that triggers this event on stat change
  # This makes it easy to update the contentView
  # def register_observers
  #   App.notification_center.observe IntefaceStateChanged do |interface_state|
      
  #   end
  # end

  def current_state
    :welcome
  end

  def view_controller_for_state
    return case current_state
    when :welcome
      welcome_controller
    end
  end

  def popover
    if @_popover.nil?
      @_popover = NSPopover.alloc.init
      @_popover.behavior = NSPopoverBehaviorTransient
      @_popover.animates = true
      @_popover.delegate = self
    end
    return @_popover
  end

  def welcome_controller
    @_welcome_controller ||= WelcomeController.new
  end

  #
  # Delegate methods
  # Makes sure the popover closes properly when clicking
  # outside it.
  #
  def popoverDidShow notification
    if @popover_transiency_monitor.nil?
      @popover_transiency_monitor = NSEvent.addGlobalMonitorForEventsMatchingMask(NSLeftMouseUp, handler: lambda{|event|
          close
        })
    end
  end

  def popoverDidClose notification
    NSEvent.removeMonitor(@popover_transiency_monitor)
    @popover_transiency_monitor = nil
    @displaying = false
  end
end
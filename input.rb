module Input
  def self.key_down?(key_code)
    return Fab2D.instance.button_down?(key_code)
  end
  def self.key_up?(key_code)
    return Fab2D.instance.button_up?(key_code)
  end
end

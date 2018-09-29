module Input
  def self.key_down?(key_code)
    return Belva2D.Reference.button_down?(key_code)
  end
  def self.key_up?(key_code)
    return Belva2D.Reference.button_up?(key_code)
  end
end

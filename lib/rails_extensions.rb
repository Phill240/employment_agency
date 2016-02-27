class Hash
  
  def pick(values)
    self.reject {|k, v| !Array(values).map(&:to_s).include?(k.to_s)}
  end
  
end
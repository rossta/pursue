class Periodization
  include Enumerable
  include Virtus.model

  def each(&block)
    raise "subclass must implement #each"
  end

end

NullDate = Struct.new(:text) do
  include Comparable
  include Enumerable

  def +(fixnum)
    self
  end

  def -(fixnum)
    self
  end

  def <=>(date)
    0
  end

  def <<(fixnum)
    self
  end

  def >>(fixnum)
    self
  end

  def ==(date)
    date.is_a?(NullDate)
  end

  def each(&block)
  end

  def succ
    self
  end

  def length
    0
  end

  def to_s(*args)
    text
  end
  alias_method :strftime, :to_s

  def wday
    -1
  end

  def mon
    -1
  end
end

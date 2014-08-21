class AnonymousUser < SimpleDelegator

  def initialize
    super(User.new)
  end

end

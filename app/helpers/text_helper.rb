module TextHelper
  def pluralize_without_count(count, noun, text = nil)
    return if count.zero?
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end
end

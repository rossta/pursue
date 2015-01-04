module ApplicationHelper
  include GravatarImageTag

  def render_labels(labels, classes = nil)
    labels.reject(&:blank?).map { |l| render_label(l, classes) }.join(' ').html_safe
  end

  def render_label(label, classes = nil)
    classes = ['label'] + [classes].flatten.compact
    content_tag(:span, label, class: classes)
  end
end

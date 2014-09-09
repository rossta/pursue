module FlashHelper

  def flash_class(key)
    I18n.t("flash.class.#{key}") || key
  end
end

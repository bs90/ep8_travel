module Api::V1::Pagination
  include Pagy::Backend
  extend ActiveSupport::Concern

  included do
    def pagy_posts(collection)
      options = {page:, items:}
      pagy_info, records = pagy(collection, options)
      [pagy_info_filtered(pagy_info), records]
    end
  end

  private
  def pagy_info_filtered(pagy_info)
    except_keys = Settings.pagy.except_keys
    pagy_info.instance_values.except(*except_keys)
  end

  def page
    @page ||= begin
      requested_page = params[:page].to_i
      requested_page.positive? ? requested_page : Settings.pagy.page
    end
  end

  def items
    @items ||= begin
      requested_items = params[:per_page].to_i
      requested_items.positive? ? requested_items : Settings.pagy.items
    end
  end
end

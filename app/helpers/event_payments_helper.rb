# frozen_string_literal: true

module EventPaymentsHelper
  def event_payment_categories
    [:hostel] + registration_payment_categories
  end
end

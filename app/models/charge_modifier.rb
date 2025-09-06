# Klasse um Kosten von Veranstaltungen anzupassen
class ChargeModifier < ApplicationRecord
  # Versionskontrolle
  has_paper_trail

  # Zu dieser Person gehört der Kontakt
  belongs_to :registration

  # Validierungen
  validates :registration, :money_amount, :reason, presence: true

  def object_name
    "#{registration&.event ? registration.event.title : 'Unknown event'} » " \
    "#{registration&.event ? registration&.person&.full_name : 'Unknown person'}"
  end
end

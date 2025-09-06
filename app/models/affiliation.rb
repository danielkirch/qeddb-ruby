# Die Klasse "Affiliation" dient zur Verwaltung einer einzelnen Gruppenzugehörigkeit.
#
# Eine Gruppenzugehörigkeit besteht einer Eintrag, welcher über einen Zeitraum
# einer Gruppe hinzugefügt wird. Dieser Eintrag kann entweder eine Person sein oder
# eine weitere Gruppe.

class Affiliation < ApplicationRecord
  # Versionskontrolle
  has_paper_trail

  # Gibt die Gruppen an, zu welcher dieser Eintrag hinzugefügt werden.
  belongs_to :group
  # Die eingetragene Person oder Gruppe (-> polymorphes Attribut "groupable")
  belongs_to :groupable, polymorphic: true

  validates :groupable_type, inclusion: { in: %w[Person Group] }
  validate :time_ordering

  default_scope { order(start: :desc) }

  # Prüfe, ob Anfang vor Ende kommt.
  def time_ordering
    return if start.nil? || self.end.nil? || start <= self.end

    errors.add :start, " muss früher als #{Affiliation.human_attribute_name :end} sein"
  end

  def object_name
    "#{group ? group.title : 'Unknown group'} » #{groupable ? groupable.object_name : 'Unknown element'}"
  end
end

# frozen_string_literal: true

class CharacterFrequencyPresenter
  def initialize(people_list)
    @people_list = people_list
  end

  def summary
    @summary ||= begin
      email_addresses = people_list.map { |person| person[:email_address].downcase }
      occurrences = email_addresses.each_with_object(Hash.new(0)) do |email, character_counts|
        email.each_char { |c| character_counts[c] += 1 }
      end
      occurrences.sort_by { |_, value| -value }
    end
  end

  private

  attr_reader :people_list
end

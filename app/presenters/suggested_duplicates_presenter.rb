# frozen_string_literal: true

class SuggestedDuplicatesPresenter
  DEFAULT_DISTANCE_THRESHOLD = 1

  attr_reader :distance_threshold

  def initialize(people_list, distance_threshold = DEFAULT_DISTANCE_THRESHOLD)
    @people_list = people_list
    @distance_threshold = distance_threshold
  end

  def summary
    @summary ||= begin
      # group into buckets by domain such that we search for possible dupes within a given domain only
      people_by_domain = @people_list.group_by { |person| person[:email_address].split('@').last }.select { |_, entries| entries.length > 1 }

      suggestions = people_by_domain.each_with_object(Set[]) do |tuple, results|
        tuple.last.each do |person|
          possible_dupes = tuple.last.select do |p|
            if person[:email_address] == p[:email_address]
              false
            else
              distance = levenshtein_distance(person[:email_address], p[:email_address])
              distance <= distance_threshold
            end
          end
          results.merge(possible_dupes)
        end
        results
      end
      suggestions
    end
  end

  private

  #
  # Calculates the number of changes (adds, swaps, deletes) necessary to make
  # two strings identical. The lower the score the closer in similarity they are.
  #
  # See: https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance
  #
  def levenshtein_distance(first, second)
    matrix = [(0..first.length).to_a]
    (1..second.length).each do |j|
      matrix << [j] + [0] * first.length
    end

    (1..second.length).each do |i|
      (1..first.length).each do |j|
        matrix[i][j] = if first[j - 1] == second[i - 1]
                         matrix[i - 1][j - 1]
                       else
                         [
                           matrix[i - 1][j],
                           matrix[i][j - 1],
                           matrix[i - 1][j - 1]
                         ].min + 1
                       end
      end
    end
    matrix.last.last
  end

  attr_reader :people_list
end

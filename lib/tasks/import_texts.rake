# frozen_string_literal: true

namespace :setup do
  desc 'Import the text votes into the db'
  task :import_texts, [:filename] => :environment do |_task, args|
    return unless args[:filename].split('.').last == 'txt'

    file_path = Rails.root.join args[:filename]
    votes = File.new(file_path).to_a

    import_count = 0

    corrupt_data = votes.each_with_object([]) do |data, array|
      data = fix_encoding(data) unless data.valid_encoding?

      fields = data.split(' ')
      campaign_title = fields[2].split(':').last
      validity = fields[3].split(':').last
      choice = fields[4].split(':').last

      # discard if we have no campaign details
      if campaign_title.nil? || campaign_title.empty?
        array << data
        next
      end

      campaign = Campaign.find_or_create_by(title: campaign_title)
      vote = Vote.new(campaign_id: campaign.id, choice: choice, validity: validity)

      # discard if we dont have the appropriate data
      unless vote.valid?
        array << data
        next
      end

      vote.save
      import_count += 1
      puts "Created vote with id: #{vote.id}, campaign: #{campaign_title}, validity: #{validity}, choice: #{choice}"
    end

    puts "#{import_count} votes successfully imported"

    if corrupt_data.any?
      puts "#{corrupt_data.count} corrupt votes found:"
      puts corrupt_data
    end
  end

  def fix_encoding(data)
    data.encode('UTF-16be', invalid: :replace, replace: '?').encode('UTF-8')
  end
end

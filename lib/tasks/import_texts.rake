# frozen_string_literal: true

namespace :setup do
  desc 'Import the text votes into the db'
  task :import_texts, [:filename] => :environment do |_task, args|
    return unless args[:filename].split('.').last == 'txt'

    file_path = Rails.root.join args[:filename]
    votes = File.new(file_path).to_a

    campaigns = Campaign.all.each_with_object({}) { |campaign, object| object[campaign.title] = campaign.id }
    import_count = 0

    corrupt_data = Campaign.transaction do
      votes.each_with_object([]) do |data, array|
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

        campaign_id = campaigns[campaign_title] ||= Campaign.create(title: campaign_title).id
        vote = Vote.new(campaign_id: campaign_id, choice: choice, validity: validity)

        unless vote.valid?
          array << data
          next
        end

        vote.save
        import_count += 1
      end
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

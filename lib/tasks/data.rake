require 'pry'
require 'csv'
require 'smarter_csv'
require_relative '../data_transform.rb'

namespace :data do
  include DataTransform
  desc "from text to csv"
  task txt2csv: :environment do
    Dir['./data/txt/*.txt'].each do |file|

      @entries = []
      @fields = {}
      File.open(file).readlines.each do |line|
        if is_record?(line)
          if is_start?(line)
            @entries << @fields if @fields
            @fields = {}
          end
          field, value = parse_record(line)
          @fields[field] = value
        end
      end

      headers = @entries.map{|h| h.keys}.flatten.uniq
      CSV.open("./data/csv/#{File.basename(file, File.extname(file))}.csv", 'wb') do |csv|
        csv << headers
        @entries.each do |entry|
          row = headers.map do |key|
            entry[key]
          end
          csv << row
        end
      end

    end
  end

  desc "inserts csv data into db"
  task csv2db: :environment do
    Dir['./data/csv/*.csv'].each do |file|
      data = SmarterCSV.process(file, key_mapping: {organization: :name})
      data.each do |datum|
        if datum[:category]
          @category =
            if Category.where(name: datum[:category]).exists?
              Category.where(name: datum[:category]).first
            else
              Category.create!(name: datum[:category])
            end
        else
          model_fields = [:name, :description, :phone, :website, :location]
          service = Service.create!(datum.slice(*model_fields))
          other_fields = datum.keys - model_fields
          service.update_attributes!(
            other: datum.slice(*other_fields).to_a.map {|a,b|
              "#{a}: #{b}"
            }.join("\n")
          )
          service.categories << @category
          service.save!
        end
      end
    end

  end
end

require 'csv'

namespace :tax_references do
  desc 'Import published reference years without overwriting existing values'
  task import_published: :environment do
    created = []
    unchanged = []

    TaxReference.transaction do
      CSV.foreach(Rails.root.join('db/data/tax_references.csv'), headers: true) do |row|
        reference = TaxReference.find_or_initialize_by(year: Integer(row.fetch('year')))
        reference.assign_attributes(row.to_h)

        if reference.persisted?
          if reference.changed?
            raise "Existing reference for #{reference.year} differs from published data; no records were changed. Review it explicitly before importing."
          end
          unchanged << reference.year
        else
          reference.save!
          created << reference.year
        end
      end
    end

    puts "Created years: #{created.join(', ')}"
    puts "Already matching: #{unchanged.join(', ')}"
  end
end

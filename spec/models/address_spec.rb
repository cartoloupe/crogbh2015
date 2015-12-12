require 'rails_helper'

describe Address, type: :model do
  describe '.build_from_text' do
    # Lets

    let(:street_qualifier)     { 'St.' }
    let(:street_separator)     { ' ' }
    let(:street_name)          { 'Main St.' }
    let(:street_number)        { rand(100..99999).to_s }

    let(:unit_label)           { 'Suite' }
    let(:unit)                 { rand(1..99999).to_s }

    let(:city)                 { 'Columbus' }
    let(:city_state_separator) { ', ' }
    let(:state)                { 'OH' }

    let(:zip_code) { '' }
    let(:zip_separator) { '' }
    let(:zip_extension) { '' }

    let(:street_address) { "#{street_number}#{street_separator}#{street_name}#{street_separator}#{street_qualifier}" }
    let(:unit_info)      { "#{unit_label} #{unit}" }
    let(:city_state)     { "#{city}#{city_state_separator}#{state}" }
    let(:zip)            { "#{zip_code}#{zip_separator}#{zip_extension}" }

    let(:address_separator) { ",\n" }
    let(:input) do
      randomize_case(
        [
          street_address,
          unit_info,
          city_state,
          zip,
        ]
        .select { |part| part.present? }
        .join address_separator
      )
    end

    let(:expected_street_qualifier) do
      case street_qualifier.downcase.gsub(/[^a-z]/, '')
      when 'avenue',    'ave', 'av' then 'Ave'
      when 'boulevard', 'blvd'      then 'Blvd'
      when 'drive',     'drv', 'dr' then 'Dr'
      when 'parkway',   'pkwy'      then 'Pkwy'
      when 'path'                   then 'Path'
      when 'road',      'rd'        then 'Rd'
      when 'street',    'str', 'st' then 'St'
      when 'trail',     'trl', 'tr' then 'Trl'
      when 'way'                    then 'Way'
        # circle
        # court
        # place
        # freeway
        # expressway
        # highway
        # tollway
        ### check the address parser gem's source code
      # ... more?
      end
    end

    let(:expected_street) do
      "#{street_number} #{street_name} #{expected_street_qualifier}"
    end

    # Subject

    subject { described_class.build_from_text input }

    # Tests

    context 'without a street address' do
      let(:street_name)      { }
      let(:street_number)    { }
      let(:street_qualifier) { }

      it { is_expected.to be nil }
    end

    context 'with a street address' do
      its(:street) { is_expected.to eq expected_street }
    end

    context 'with extra whitespace in the street address' do
      let(:street_separator) { '  ' }

      its(:street) { is_expected.to eq expected_street }
    end

    context 'with a unit' do
      let(:unit)       { 123 }
      let(:unit_label) { 'Suite' }

      its(:unit) { is_expected.to eq unit }
      its(:unit_label) { is_expected.to eq unit_label }
    end

    context 'with a city' do
      let(:city)          { 'Columbus' }
      let(:expected_city) { 'Columbus' }

      context 'and a state abbreviation' do
        let(:state)          { 'OH' }
        let(:expected_state) { 'OH' }

        its(:city)  { is_expected.to eq city }
        its(:state) { is_expected.to eq state }
      end

      context 'and a state name' do
        let(:state)          { 'Ohio' }
        let(:expected_state) { 'OH' }

        its(:city)  { is_expected.to eq city }
        its(:state) { is_expected.to eq expected_state }
      end

      context 'and no state' do
        let(:state) { }

        it { is_expected.to be nil }
      end
    end

    context 'without a city' do
      let(:city) { }

      it { is_expected.to be nil }
    end

    [
      ' ',
      ', ',
    ].each do |separator|
      context "when the city and state are separated by '#{separator}'" do
        let(:city_state_separator) { separator }

        its(:city)  { is_expected.to eq city }
        its(:state) { is_expected.to eq state }
      end
    end

    context 'with a zip code' do
      let(:zip_code) { rand 10000..99999 }

      its(:zip) { is_expected.to eq zip_code }

      context 'with an extension' do
        let(:zip_extension) { rand 1000..9999 }

        context 'and no separator'  do
          let(:zip_separator) { '' }
          its(:zip) { is_expected.to eq "#{zip_code}-#{zip_extension}" }
        end

        context 'and a hyphen separator'  do
          let(:zip_separator) { '-' }
          its(:zip) { is_expected.to eq "#{zip_code}-#{zip_extension}" }
        end

        context 'and a space separator'  do
          let(:zip_separator) { ' ' }
          its(:zip) { is_expected.to eq "#{zip_code}-#{zip_extension}" }
        end
      end
    end
  end
end

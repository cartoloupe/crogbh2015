require 'rails_helper'

describe UserTypes do
  # variables

  the_class = described_class # workaround for a context limitation

  all_inputs = the_class.types + the_class.detail_classes

  # subject

  subject { described_class }

  # shared examples

  shared_examples 'it raises exceptions for bad multi-type input' do
    context 'given a class which is not a user detail class' do
      let(:input) { Object }
      it 'raises an exception' do
        expect { subject }.to raise_error UserTypes::InvalidDetailClass
      end
    end

    context 'given a symbol which is not a user type' do
      let(:input) { :invalid_user_type_test }
      it 'raises an exception' do
        expect { subject }.to raise_error UserTypes::InvalidTypeSymbol
      end
    end

    context 'given not nil, a symbol, or a class' do
      let(:input) { 13 }
      it 'raises an exception' do
        expect { subject }.to raise_error UserTypes::InvalidInput
      end
    end
  end

  # tests

  describe '.count' do
    subject { the_class.count }
    it { is_expected.to eq 3 }
  end

  describe '.each' do
    it 'runs the block the right number of times' do
      count = 0
      the_class.each { |_, _| count += 1 }
      expect(count).to eq the_class.count
    end

    it 'has each expected type' do
      remaining = [:none, :end_user, :admin]
      the_class.each { |type, _| remaining -= [type] }
      expect(remaining.count).to eq 0
    end
  end

  describe '.each_except' do
    # test against each type
    the_class.each do |excepted_type, _|
      context "when given #{excepted_type.inspect}" do
        it 'runs the block for all but the excepted type' do
          the_class.each_except(excepted_type) do |yielded_type, _|
            expect(yielded_type).not_to eq excepted_type
          end
        end
      end
    end

    context 'with multiple arguments' do
      excepted_types = the_class.types[0..1]
      it 'excludes each type' do
        the_class.each_except(*excepted_types) do |yielded_type, _|
          expect(excepted_types).not_to include yielded_type
        end
      end
    end
  end

  describe '.types' do
    subject { super().types }

    it { is_expected.to be_an Array }
    it { is_expected.to contain_only Symbol }
  end

  describe '.detail_classes' do
    subject { super().detail_classes }

    it { is_expected.to be_an Array }
    it { is_expected.to contain_only(Class, NilClass) }
  end

  describe '.[]' do
    subject { super()[input] }

    it_behaves_like 'it raises exceptions for bad multi-type input'

    # test against each type and detail class
    the_class.each do |type, detail_class|
      context "when given #{type.inspect}" do
        let(:input) { type }
        it { is_expected.to eq detail_class }
      end

      context "when given class #{detail_class}" do
        let(:input) { detail_class }
        it { is_expected.to eq type }
      end
    end
  end

  describe '.detail_class_for' do
    subject { super().detail_class_for input }

    it_behaves_like 'it raises exceptions for bad multi-type input'

    # test against each type and detail class
    all_inputs.each do |input|
      context "given #{input.inspect}" do
        let(:input)           { input }
        let(:expected_output) { input.is_a?(Symbol) ? the_class[input] : input }
        it { is_expected.to eq expected_output }
      end
    end

    # test against user objects
    the_class.each do |type, detail_class|
      context "given user with type #{type.inspect}" do
        let(:input) { user_with_type type }
        it { is_expected.to eq detail_class }
      end
    end
  end

  describe '.type_for' do
    subject { super().type_for input }

    it_behaves_like 'it raises exceptions for bad multi-type input'

    # test against each type and detail class
    all_inputs.each do |input|
      context "given #{input.inspect}" do
        let(:input)           { input }
        let(:expected_output) { input.is_a?(Symbol) ? input : the_class[input] }
        it { is_expected.to eq expected_output }
      end
    end

    # test against user objects
    the_class.each do |type, _|
      context "given user with type #{type.inspect}" do
        let(:input) { user_with_type type }
        it { is_expected.to eq type }
      end
    end
  end

  describe '.match?' do
    context 'the first argument' do
      subject { super().match?(input, nil) }
      it_behaves_like 'it raises exceptions for bad multi-type input'
    end

    context 'the second argument' do
      subject { super().match?(nil, input) }
      it_behaves_like 'it raises exceptions for bad multi-type input'
    end

    context 'with combination' do
      subject { super().match?(input_a, input_b) }

      # try each type against each type and detail class
      all_inputs.each do |input|
        context input.inspect do
          let(:input_a) { input }

          # should match itself
          context "and itself" do
            let(:input_b) { input }
            it { is_expected.to be true }
          end

          # should match it's pair
          context "and it's pair" do
            let(:input_b) { the_class[input] }
            it { is_expected.to be true }
          end

          # shouldn't match anything else
          other_inputs = all_inputs - [input, the_class[input]]
          other_inputs.each do |other_input|
            context "and #{other_input.inspect}" do
              let(:input_b) { other_input }
              it { is_expected.to be false }
            end
          end
        end
      end
    end
  end
end

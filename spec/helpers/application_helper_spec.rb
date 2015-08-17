require 'rails_helper'

describe ApplicationHelper do
  subject { helper }

  describe '#newline_to_br' do
    subject { super().newline_to_br input }

    context 'with newlines' do
      let(:input) { "this\nis\na\ntest" }

      it 'changes them to break tags' do
        expect(subject).to eq 'this<br>is<br>a<br>test'
      end
    end

    context 'with leading breaks' do
      let(:input) { "\n\nhello,\nworld" }

      it 'removes them' do
        expect(subject).to eq 'hello,<br>world'
      end
    end

    context 'with trailing breaks' do
      let(:input) { "a\nb\nc\n\n" }

      it 'removes them' do
        expect(subject).to eq 'a<br>b<br>c'
      end
    end

    context 'with html tags' do
      # this is important because to render the output, you need to wrap it in a
      # call to `raw`
      j
      let(:input) { '<p>hi</p>' }

      it 'escapes them' do
        expect(subject).to eq '&lt;p&gt;hi&lt;/p&gt;'
      end
    end
  end

  describe '#humanize' do
    let(:input) { :"this-is-a-test" }
    subject { super().humanize input }

    it 'splits at hyphens and capitalizes each word' do
      expect(subject).to eq 'This Is A Test'
    end
  end

  describe '#display_map' do
    let(:address) { '2 Miranova Pl, Columbus, OH' }

    subject { super().display_map address }

    it 'creates a div container' do
      expect(subject).to include '<div'
    end

    it 'adds a javascript call' do
      expect(subject).to include '<script'
      expect(subject).to include 'codeAddress('
    end
  end
end

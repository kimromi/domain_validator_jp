# frozen_string_literal: true

RSpec.describe DomainValidatorJp do
  describe '#valid?' do
    subject { described_class.valid?(domain) }

    describe 'valid' do
      context 'english domain' do
        let(:domain) { 'example.com' }

        it { is_expected.to be_truthy }
      end

      context 'japanese domain' do
        let(:domain) { '日本語.com' }

        it { is_expected.to be_truthy }
      end
    end

    describe 'invalid' do
      context 'tld' do
        let(:domain) { 'example.invalidtld' }

        it { is_expected.to be_falsey }
      end

      context 'japanese domain' do
        let(:domain) { '①②③.com' }

        it { is_expected.to be_falsey }
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe DomainValidatorJp do
  describe '#valid?' do
    subject { described_class.new(domain).valid? }

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
      context 'subdomain' do
        let(:domain) { 'sub.example.com' }

        it { is_expected.to be_falsey }
      end

      context 'tld' do
        let(:domain) { 'example.invalidtld' }

        it { is_expected.to be_falsey }
      end

      context 'domain length' do
        let(:domain) { "#{'d' * 250}.com" }

        it { is_expected.to be_falsey }
      end

      context 'sld length' do
        let(:domain) { "#{'d' * 64}.com" }

        it { is_expected.to be_falsey }
      end

      context 'japanese domain' do
        let(:domain) { '①②③.com' }

        it { is_expected.to be_falsey }
      end
    end
  end
end

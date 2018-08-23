# frozen_string_literal: true

RSpec.describe DomainValidatorJp do
  describe '#valid?' do
    subject { described_class.valid?(domain) }

    describe 'valid' do
      context 'english domain' do
        let(:domain) { 'example.com' }

        it { is_expected.to be_truthy }
      end

      %w(
        にほんご
        ニホンゴ
        日本語
        ぁ
        ァ
        ・ヽヾゝゞ仝々〆〇ー
      ).each do |valid_japanese|
        context "japanese domain #{valid_japanese}" do
          let(:domain) { "#{valid_japanese}.com" }

          it { is_expected.to be_truthy }
        end
      end

      context 'japanese + english domain' do
        let(:domain) { '日本語japanese.com' }

        it { is_expected.to be_truthy }
      end

      context 'japanese + hyphen + english domain' do
        let(:domain) { '日本語-japanese.com' }

        it { is_expected.to be_truthy }
      end

      context 'punycode domain' do
        let(:domain) { 'xn--wgv71a119e.com' } # 日本語.com

        it { is_expected.to be_truthy }
      end
    end

    describe 'invalid' do
      describe 'invalid fqdn' do
        %w(
          .com
          example.
          .
          example..com
          .example.com
        ).each do |invalid_fqdn|
          context "#{invalid_fqdn}" do
            let(:domain) { invalid_fqdn }

            it { is_expected.to be_falsey }
          end
        end
      end

      describe 'singlebyte' do
        context 'subdomain' do
          let(:domain) { 'sub.example.com' }

          it { is_expected.to be_falsey }
        end

        context 'tld' do
          let(:domain) { 'example.invalidtld' }

          it { is_expected.to be_falsey }
        end

        context 'start with hyphen' do
          let(:domain) { '-example.com' }

          it { is_expected.to be_falsey }
        end

        context 'end with hyphen' do
          let(:domain) { 'example-.com' }

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

        context 'domain equals cctld with subdomain' do
          let(:domain) { 'co.uk' }

          it { is_expected.to be_falsey }
        end
      end

      describe 'multibyte' do
        context 'subdomain' do
          let(:domain) { 'sub.日本語.com' }

          it { is_expected.to be_falsey }
        end

        context 'tld' do
          let(:domain) { '日本語.invalidtld' }

          it { is_expected.to be_falsey }
        end

        context 'start with hyphen' do
          let(:domain) { '-日本語.com' }

          it { is_expected.to be_falsey }
        end

        context 'end with hyphen' do
          let(:domain) { '日本語-.com' }

          it { is_expected.to be_falsey }
        end

        context 'domain length' do
          let(:domain) { "#{'日' * 16}.com" }

          it { is_expected.to be_falsey }
        end

        %w(
          ＡＢＣ
          １２３
          ①②③
          〜
          ＠
          ä
          〠
          −
        ).each do |invalid_japanese|
          context "japanese domain #{invalid_japanese}" do
            let(:domain) { "#{invalid_japanese}.com" }

            it { is_expected.to be_falsey }
          end
        end
      end
    end
  end
end

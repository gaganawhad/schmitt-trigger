require 'spec_helper'

describe SchmittTrigger do
  describe 'initialize' do
    it 'takes two arguments to initialize' do
      expect { described_class.new }.to raise_error ArgumentError
      expect { described_class.new(1) }.to raise_error ArgumentError
      expect(described_class.new(1, 3)).to be_a SchmittTrigger
    end

    it 'raises an error when the upper_threshold is lower than the lower_threshold' do
      expect { described_class.new(4, 3) }.to raise_error(SchmittTrigger::LowerThresholdGreaterThanUpperThreshold)
    end

    it 'raises an error when the upper_threshold is the same as lower_threshold' do
      expect { described_class.new(4, 4) }.to raise_error(SchmittTrigger::LowerThresholdSameAsUpperThreshold)
    end
  end

  describe '#run' do
    let(:subject) { described_class.new(2, 5) }

    context 'when cold starting' do
      it 'returns lower_threshold as the first output value until upper threshold is crossed' do
        expect(subject.run([1, 2, 3])).to eq [2, 2, 2]
      end

      it 'returns upper_threshold once the input matches uppper threshold' do
        expect(subject.run([1, 2, 5, 6])).to eq [2, 2, 5, 5]
      end
    end

    context 'when output is at uppper_threshold' do
      before do
        subject.run(6)
        expect(subject.output).to eq 5
      end

      it 'continues to return upper threshod until the input crosses lower threshold' do
        expect(subject.run([6, 4, 2, 1])).to eq [5, 5, 2, 2]
      end
    end

    context 'when output is at lower_threshold' do
      before do
        subject.run(-3)
        expect(subject.output).to eq 2
      end

      it 'continues to return lower threshod until the input crosses upper threshold' do
        expect(subject.run([-2, 3, 4, 6])).to eq [2, 2, 2, 5]
      end
    end
  end
end

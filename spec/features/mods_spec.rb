require 'spec_helper'

describe MetadataCop::Cop::Mods do

  let(:runner) { MetadataCop::Runner.new(cops: MetadataCop::ConfigLoader.new(type: 'mods').cops) }

  subject { runner.tap { |r| r.run(record) } }

  context 'with a bad file' do
    let(:record) { 'this is not a MODS record' }

    it 'is not valid' do
      expect(subject).not_to be_success
    end
  end

  context 'with a valid MODS document' do
    let(:record) { fixtures_path('lc_digitized_photo.mods.xml') }

    it 'is valid' do
      expect(subject).to be_success
    end
  end

  context 'with an invalid MODS document' do
    let(:record) { fixtures_path('xf680rd3068.mods.xml') }

    it 'is missing an identifier' do
      expect(subject).not_to be_success
      expect(subject.offenses[record].map(&:message)).to include(/Record must have an identifier/)
    end
  end

  def fixtures_path(*args)
    File.join(File.expand_path('../../fixtures', __FILE__), 'mods', *args)
  end
end

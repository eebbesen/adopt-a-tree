require 'rails_helper'

class NoNameThingy
end

RSpec.describe ThingMailer do
  context '#thing_name' do
    it 'uses name when name' do
      expect(ThingNameHelper.thing_name(Thing.new(name: 'Twiggy'))).to eq('Twiggy')
    end

    it 'uses default when no name' do
      expect(ThingNameHelper.thing_name(NoNameThingy.new)).to eq('tree')
    end

    it 'appends modifier when passed' do
      expect(ThingNameHelper.thing_name(Thing.new, 'your')).to eq('your tree')
    end
  end

  context 'mailer methods' do
    let(:user) { User.new(id: 12, email: 'you@nice.org', first_name: 'C. T.', last_name: ' Zen') }
    let(:thing) { Thing.new(name: 'Twiggy', user: user) }

    context '::reminder' do
      it 'has the expected subject with thing name' do
        expect(ThingMailer.reminder(thing).subject).to eq 'Remember to water Twiggy'
      end

      it 'has the expected subject with a thing without name' do
        thing.name = nil
        expect(ThingMailer.reminder(thing).subject).to eq 'Remember to water your tree'
      end
    end

    context '::abandon' do
      it 'has the expected subject and body' do
        mail = ThingMailer.abandon(thing, 'you@nice.org')
        expect(mail.subject).to eq "Thank you for your taking care of a tree, we'll miss you!"
        expect(mail.body).to eq "We'd love to have you back when you are able to adopt a tree again."
      end
    end

    context '::adopt' do
      it 'has the expected subject and body with thing name' do
        mail = ThingMailer.adopt(thing)
        expect(mail.subject).to eq "Thank you for adopting Twiggy!"
        expect(mail.body).to eq "We'll send reminders to water Twiggy.\nAsk your friends and neighbors to help, too!"
      end

      it 'has the expected subject and body with a thing without a name' do
        thing.name = nil
        mail = ThingMailer.adopt(thing)
        expect(mail.subject).to eq "Thank you for adopting a tree!"
        expect(mail.body).to eq "We'll send reminders to water your tree.\nAsk your friends and neighbors to help, too!"
      end
    end
  end
end
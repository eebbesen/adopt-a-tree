require 'rails_helper'

RSpec.describe ThingsController, :type => :controller do

  let(:thing) { create(:thing) }
  let(:user) { create(:user) }
  subject(:things_controller) { ThingsController.new }

  before do
    things_controller.instance_variable_set(:@thing, thing)
  end

  context '#is_abandon?' do
    context 'thing already adopted' do
      it 'is_abandon? identifies abandon' do
        expect(things_controller.send(:is_abandon?, 12)).to eq(true)
      end

      it 'is_abandon? does not misidentify when user_id not updated' do
        thing.user_id = 12
        expect(things_controller.send(:is_abandon?, 12)).to eq(false)
      end
    end
    context 'thing not yet adopted' do
      it 'is_abandon? does not misidentify when user_id not updated' do
        expect(things_controller.send(:is_abandon?, nil)).to eq(false)
      end

      it 'is_abandon? does not misidentify when adopted' do
        thing.user_id = 12
        expect(things_controller.send(:is_abandon?, nil)).to eq(false)
      end
    end
  end

  context '#is_adopt?' do
    context 'thing already adopted' do
      it 'is_adopt? does not misidentify when abandoned' do
        expect(things_controller.send(:is_adopt?, 12)).to eq(false)
      end

      it 'is_adopt? does not misidentify when user_id not updated' do
        thing.user_id = 12
        expect(things_controller.send(:is_adopt?, 12)).to eq(false)
      end
    end
    context 'thing not yet adopted' do
      it 'is_adopt? does not misidentify when still not adopted' do
        expect(things_controller.send(:is_adopt?, nil)).to eq(false)
      end
      it 'is_adopt? identifies when adopted' do
        thing.user_id = 12
        expect(things_controller.send(:is_adopt?, nil)).to eq(true)
      end
    end
  end

  context '#mail_handler' do
    context 'when no triggering change' do
      it 'should not send any mail' do
        things_controller.send(:mail_handler, nil)
      end
    end

    context 'should send emails when triggered' do
      let(:mail) { double('Mail') }
      it 'should send abandon mail' do
        expect(ThingMailer).to receive(:abandon).with(instance_of(Thing), instance_of(String)).and_return(mail)
        expect(mail).to receive(:deliver)
        things_controller.send(:mail_handler, 1)
      end
      it 'should send adopt mail' do
        thing.user_id = 12
        expect(ThingMailer).to receive(:adopt).with(instance_of(Thing)).and_return(mail)
        expect(mail).to receive(:deliver)
        things_controller.send(:mail_handler, nil)
      end
    end
  end

  # REST tests
  it 'should list things' do
    get :show, format: 'json', lat: 42.358431, lng: -71.059773
    things = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(things.count).to eq(3)
  end

  it 'should update thing' do
    expect(thing.name).to be_nil
    put :update, format: 'json', id: thing.id, thing: {name: 'Birdsill'}
    thing.reload
    expect(response.status).to eq(204)
    expect(thing.name).to eq('Birdsill')
  end
end
